//
//  DetailViewController.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "DetailViewController.h"
#import "Agent.h"
#import "Domain+Implementation.h"
#import "FreakType+Implementation.h"
#import "Domain.h"
#import "FreakType.h"

static NSString *const kAgentDestructionForceChanged = @"agent.agentDestructionPower";
static NSString *const kAgentMotivationChanged = @"agent.agentMotivation";

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInputText;
@property (weak, nonatomic) IBOutlet UITextField *freakTypeInputText;
@property (weak, nonatomic) IBOutlet UITextField *domainInputText;
@property (weak, nonatomic) IBOutlet UIStepper *destructionPowerStepper;
@property (weak, nonatomic) IBOutlet UIStepper *motivationStepper;
@property (weak, nonatomic) IBOutlet UILabel *destructionPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *motivationLabel;
@property (weak, nonatomic) IBOutlet UILabel *contratacionLabel;


@property (nonatomic, strong) NSArray *destructionPowerSentences;
@property (nonatomic, strong) NSArray *motivationSentences;
@property (nonatomic, strong) NSArray *resultSentences;

@end

@implementation DetailViewController

#pragma mark - LifeCycle methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSentences];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addObserver:self forKeyPath:kAgentDestructionForceChanged options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kAgentMotivationChanged options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init properties methods.
- (void)initSentences
{
    self.destructionPowerSentences = @[@"Flojo", @"Medio", @"Fuerte", @"Nuclear"];
    self.motivationSentences = @[@"Nada motivado", @"Algo motivado", @"Muy motivado", @"Pocholo"];
    self.resultSentences = @[@"No vale", @"Justito", @"Es valido", @"Un crack", @"Muy crack"];
}
- (void)configureView
{
    //config steppers
    self.nameInputText.text = self.agent.agentName;
    self.domainInputText.text = [self stringWithDomains:self.agent.agentDomain];
    self.freakTypeInputText.text = self.agent.agentCategory.freakTypeName;
    self.motivationStepper.value = [self.agent.agentMotivation doubleValue];
    self.destructionPowerStepper.value = [self.agent.agentDestructionPower doubleValue];
    
    self.destructionPowerLabel.text = self.destructionPowerSentences[(int)self.destructionPowerStepper.value];
    self.motivationLabel.text = self.motivationSentences[(int)self.motivationStepper.value];
    self.contratacionLabel.text = self.resultSentences[self.agent.agentAppraisal.integerValue];
}

#pragma mark - BarButtonAction methods.
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self removeObservers];
    [self.delegate dismissDetailViewController:self modifiedData:NO];
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    [self preSave];
    [self removeObservers];
    [self.delegate dismissDetailViewController:self modifiedData:YES];
}

#pragma mark - Steppers methods.
- (IBAction)destructionPowerPressed:(UIStepper *)sender
{
    self.agent.agentDestructionPower = @(sender.value);
}
- (IBAction)motivationPowerPressed:(UIStepper *)sender
{
    self.agent.agentMotivation = @(sender.value);
}

#pragma mark - Observer methods.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kAgentDestructionForceChanged] || [keyPath isEqualToString:kAgentMotivationChanged])
    {
        [self updateLabels];
        self.contratacionLabel.text = self.resultSentences[self.agent.agentAppraisal.integerValue];
    }
}

#pragma mark - Own methods.
- (void)removeObservers
{
    [self removeObserver:self forKeyPath:kAgentDestructionForceChanged];
    [self removeObserver:self forKeyPath:kAgentMotivationChanged];
}

- (void)updateLabels
{
    self.destructionPowerLabel.text = self.destructionPowerSentences[(int)self.destructionPowerStepper.value];
    self.motivationLabel.text = self.motivationSentences[(int)self.motivationStepper.value];
    self.contratacionLabel.text = self.resultSentences[self.agent.agentAppraisal.integerValue];
}
#pragma mark - Assign methods.

- (void)assignName
{
    self.agent.agentName = self.nameInputText.text;
}

- (void)assignDomains
{
    NSString *domainsText = self.domainInputText.text;
    if (domainsText)
    {
        NSArray *domains = [domainsText componentsSeparatedByString:@","];
        NSMutableSet *newDomains = [NSMutableSet set];
        for (NSString *domainName in domains)
        {
            Domain *domain = [Domain fetchInMOC:self.managedObjectCotnext withName:domainName];
            if (!domain)
            {
                domain = [Domain domainInMOC:self.managedObjectCotnext withName:domainName];
            }
            
            [newDomains addObject:domain];
        }
        
        self.agent.agentDomain = newDomains;
    }

}

- (void)assignFreakType
{
    if (self.agent.agentCategory.freakTypeName != self.freakTypeInputText.text)
    {
        self.agent.agentCategory = [FreakType freakTypeInMOC:self.managedObjectCotnext withName:self.freakTypeInputText.text];
    }
}

- (void)assignDestructionPower
{
    self.agent.agentDestructionPower = @(self.destructionPowerStepper.value);
}

- (void)assignMotivation
{
    self.agent.agentMotivation = @(self.motivationStepper.value);
}

#pragma mark - PreSave method.
- (void)preSave
{
    [self assignName];
    [self assignDomains];
    [self assignFreakType];
    [self assignMotivation];
    [self assignDestructionPower];
}

- (NSString *)stringWithDomains:(NSSet *)domains
{
    NSMutableString *domainString = [NSMutableString string];
    for (Domain *domain in domains)
    {
        if (domainString.length > 0)
        {
            [domainString appendString:@", "];
        }
        [domainString appendString:domain.domainName];
    }
    return domainString;
}

@end

