//
//  Power.h
//  Malometer
//
//  Created by Julian Alonso on 5/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent;

@interface Power : NSManagedObject

@property (nonatomic, retain) NSString * powerName;
@property (nonatomic, retain) NSSet *powerAgent;
@end

@interface Power (CoreDataGeneratedAccessors)

- (void)addPowerAgentObject:(Agent *)value;
- (void)removePowerAgentObject:(Agent *)value;
- (void)addPowerAgent:(NSSet *)values;
- (void)removePowerAgent:(NSSet *)values;

@end
