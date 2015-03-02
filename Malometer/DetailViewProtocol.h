//
//  DetailViewProtocol.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailViewController;

@protocol DetailViewProtocol <NSObject>

- (void)dismissDetailViewController:(DetailViewController *)detailViewController modifiedData:(BOOL)modifiedData;

@end
