//
//  Agent.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Agent : NSManagedObject

@property (nonatomic, retain) NSString * agentName;
@property (nonatomic, retain) NSNumber * agentDestructionPower;
@property (nonatomic, retain) NSNumber * agentMotivation;
@property (nonatomic, retain) NSNumber * agentAppraisal;

@end
