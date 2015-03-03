//
//  FreakType.h
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent;

@interface FreakType : NSManagedObject

@property (nonatomic, retain) NSString * freakTypeName;
@property (nonatomic, retain) Agent *freakTypeAgents;

@end
