//
//  DetailViewController.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewProtocol.h"
#import <CoreData/CoreData.h>

@class Agent;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Agent *agent;
@property (nonatomic, strong) id<DetailViewProtocol> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectCotnext;

@end

