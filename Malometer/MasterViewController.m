//
//  MasterViewController.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Agent.h"
#import "DetailViewProtocol.h"
#import "Agent+Implementation.h"
#import "FreakType.h"
#import "Domain.h"

static NSString *const kAgentEntityName = @"Agent";
static NSString *const kAgentName = @"agentName";
static NSString *const kCreateAgentSegue = @"createAgentSegue";
static NSString *const kPathForAgentCategory = @"agentCategory.freakTypeName";

@interface MasterViewController ()

@end

@interface MasterViewController (DetailViewProtocol)<DetailViewProtocol>

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.title = [[self numberOfAgentsWithDestructionPowerGreatherThan:@(2)] stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Agent *)getNewAgent
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Agent class]) inManagedObjectContext:self.managedObjectContext];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Agent *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        UINavigationController *nc = segue.destinationViewController;
        DetailViewController *dvc = (DetailViewController *)nc.topViewController;
        
        
        dvc.agent = object;
        dvc.managedObjectCotnext = self.managedObjectContext;
    }
    
    if ([segue.identifier isEqualToString:kCreateAgentSegue])
    {
        Agent *agent = [[self fetchedResultsController] objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
//        if (self.tableView.indexPathForSelectedRow.row %2 == 0)
//        {
//            agent.;
//        }
//        else
//        {
//            agent.agentPower = @"Force";
//        }

        
        UINavigationController *nc = segue.destinationViewController;
        DetailViewController *dvc = (DetailViewController *)nc.topViewController;
        dvc.managedObjectCotnext = self.managedObjectContext;
        [self presentDetailViewController:dvc agent:agent];
    }
    
}

- (void)presentDetailViewController:(DetailViewController *)detailViewController agent:(Agent *)agent
{
    [self.managedObjectContext.undoManager beginUndoGrouping];
    
    detailViewController.delegate = self;
    
    if (!agent)
    {
        agent = [self getNewAgent];
    }
    
    detailViewController.agent = agent;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    Agent *algo = [sectionInfo.objects firstObject];
    
    return algo.agentCategory.freakTypeName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kCreateAgentSegue sender:self];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Agent *agent = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = agent.agentName;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[Agent fetchAllAgents] managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Own methods.
- (NSNumber *)numberOfAgentsWithDestructionPowerGreatherThan:(NSNumber *)number
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Domain class])];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"domainAgents.@count > %@ && (SUBQUERY(domainAgents, $x, $x.agentPowerDestruction > %@))", @(0), number];
//    __unused NSPredicate *subPredicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(Agent, $x, $x.agentPowerDestruction > %@))", number];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(domainAgents, $x, $x.agentDestructionPower > %@).@count > 0)", number];
    
    select.predicate = predicate;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:select error:nil];
    
    
    if (result.count)
    {
        return @(result.count);
    }
    
    return @(0);
}

@end

@implementation MasterViewController (DetailViewProtocol)

- (void)dismissDetailViewController:(id)detailViewController modifiedData:(BOOL)modifiedData
{
    [self.managedObjectContext.undoManager endUndoGrouping];
    
    if (modifiedData)
    {
        [self.managedObjectContext save:nil];
    }
    else
    {
        [self.managedObjectContext.undoManager undo];
    }
    
    [detailViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
