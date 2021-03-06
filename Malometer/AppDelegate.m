//
//  AppDelegate.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Agent+Implementation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *controller = (MasterViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    [self fakeAgentImporter:self.backgroundManagedObjectContext];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ironhack.Malometer" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Malometer" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Malometer.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";                   //Automatic migration.
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:[self dictionaryForAutomaticMigration] error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSDictionary *)dictionaryForAutomaticMigration
{
    return @{
             NSMigratePersistentStoresAutomaticallyOption : @YES,
             NSInferMappingModelAutomaticallyOption : @YES
             };
}

#pragma mark - Lazy getters.

@synthesize managedObjectContext = _managedObjectContext;
@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;
@synthesize rootManagedObjectContext = _rootManagedObjectContext;

- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    if (!_backgroundManagedObjectContext)
    {
        _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_backgroundManagedObjectContext setParentContext:self.managedObjectContext];
    }
    
    return _backgroundManagedObjectContext;
}

- (NSManagedObjectContext *)rootManagedObjectContext
{
    if (!_rootManagedObjectContext)
    {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator)
        {
            _rootManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [_rootManagedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _rootManagedObjectContext;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setParentContext:self.rootManagedObjectContext];
        _managedObjectContext.undoManager = [[NSUndoManager alloc] init];
    }
    return _managedObjectContext;
}

#pragma mark - Custom methods.

- (void)fakeAgentImporter:(NSManagedObjectContext *)managedObjectContext
{
    [managedObjectContext performBlock:^{
        for (int i=0; i<10000; i++)
        {
            __unused Agent *agent = [Agent agentInMOC:managedObjectContext andName:[NSString stringWithFormat:@"Agent %i", i]];
            NSLog(@"Importing %i", i);
        }
        [managedObjectContext save:NULL];
    }];
}

@end
