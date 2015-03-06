//
//  AgentToAgentMigrationPolicy.m
//  Malometer
//
//  Created by Julian Alonso on 5/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "AgentToAgentMigrationPolicy.h"
#import "Power.h"
#import "Power+Implementation.h"
#import "Agent.h"

NSString *const agentPropertyPower = @"agentPower";

@implementation AgentToAgentMigrationPolicy


- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)sInstance entityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError *__autoreleasing *)error
{
    NSManagedObject *dInstance = [NSEntityDescription insertNewObjectForEntityForName:[mapping destinationEntityName]
                                                               inManagedObjectContext:[manager destinationContext]];
    
    for (NSString *property in dInstance.entity.attributesByName)
    {
        id propertyValue = [sInstance valueForKey:property];
        
        if (propertyValue && ![propertyValue isEqual:[NSNull null]])
        {
            [dInstance setValue:propertyValue forKey:property];
        }
    }
    
    NSString *powerName = [sInstance valueForKey:agentPropertyPower];
    if (powerName)
    {
        Power *power = [Power fetchPowerInMOC:manager.destinationContext withName:powerName];
        if (!power)
        {
            power = [Power powerInMOC:manager.destinationContext withName:powerName];
        }
        [power addPowerAgentObject:(Agent *)dInstance];
    }
    
    [manager associateSourceInstance:sInstance withDestinationInstance:dInstance forEntityMapping:mapping];
    
    return YES;
}

@end
