//
//  DetailViewController.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "DetailViewController.h"
#import "Agent.h"

static NSString *const kAgentObserver = @"agentObserver";

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInputText;
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
    
    [self addObserver:self forKeyPath:kAgentObserver options:NSKeyValueObservingOptionNew context:nil];
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
    self.motivationStepper.value = [self.agent.agentMotivation doubleValue];
    self.destructionPowerStepper.value = [self.agent.agentDestructionPower doubleValue];
    
    self.destructionPowerLabel.text = self.destructionPowerSentences[(int)self.destructionPowerStepper.value];
    self.motivationLabel.text = self.motivationSentences[(int)self.motivationStepper.value];
    self.nameInputText.text = self.agent.agentName;
    [self calculateContratacionLabel];
}

#pragma mark - BarButtonAction methods.
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self removeObservers];
    [self.delegate dismissDetailViewController:self modifiedData:NO];
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    [self removeObservers];
    [self.delegate dismissDetailViewController:self modifiedData:YES];
}

#pragma mark - Steppers methods.
- (IBAction)destructionPowerPressed:(UIStepper *)sender
{
    self.agent.agentDestructionPower = @(sender.value);
    [self configureView];
}
- (IBAction)motivationPowerPressed:(UIStepper *)sender
{
    self.agent.agentMotivation = @(sender.value);
    [self configureView];
}
#pragma mark - InputText methods.
- (IBAction)nameEditingChange:(UITextField *)sender
{
    self.agent.agentName = sender.text;
}

#pragma mark - Observer methods.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kAgentObserver])
    {
        [self calculateContratacionLabel];
    }
}

#pragma mark - Own methods.
- (void)calculateContratacionLabel
{
    int contratacion = (self.motivationStepper.value + self.destructionPowerStepper.value) / 2;
    
    self.contratacionLabel.text = self.resultSentences[contratacion];
}

- (void)removeObservers
{
    [self removeObserver:self forKeyPath:kAgentObserver];
}

@end
