//
//  DetailViewController.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewProtocol.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) id<DetailViewProtocol> delegate;

@end

