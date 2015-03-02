//
//  DetailViewController.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInputText;
@property (weak, nonatomic) IBOutlet UIStepper *destructionPowerStepper;
@property (weak, nonatomic) IBOutlet UIStepper *motivationStepper;
@property (weak, nonatomic) IBOutlet UILabel *destructionPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *motivationLabel;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

//- (void)setDetailItem:(id)newDetailItem {
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//}

#pragma mark - Init properties methods.
- (void)initSentences
{
    self.destructionPowerSentences = @[@"Flojo", @"Medio", @"Fuerte", @"Nuclear"];
    self.motivationSentences = @[@"Nada motivado", @"Algo motivado", @"Muy motivado", @"Pocholo"];
    self.resultSentences = @[@"No vale", @"Justito", @"Es valido", @"Un crack", @"Muy crack"];
}
- (void)configureView {
    
    self.destructionPowerLabel.text = self.destructionPowerSentences[(int)self.destructionPowerStepper.value];
    self.motivationLabel.text = self.motivationSentences[(int)self.motivationStepper.value];
    
}

#pragma mark - BarButtonAction methods.
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate dismissDetailViewController:self modifiedData:NO];
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate dismissDetailViewController:self modifiedData:NO];
}

#pragma mark - Steppers methods.
- (IBAction)destructionPowerPressed:(UIStepper *)sender
{
    [self configureView];
}
- (IBAction)motivationPowerPressed:(UIStepper *)sender
{
    [self configureView];
}



@end
