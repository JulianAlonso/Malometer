//
//  Power+Implementation.m
//  Malometer
//
//  Created by Julian Alonso on 5/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Power+Implementation.h"

NSString *const powerEntityName = @"Power";
NSString *const powerPropertyName = @"powerName";


@implementation Power (Implementation)


+ (instancetype) powerInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    Power *power = [NSEntityDescription insertNewObjectForEntityForName:powerEntityName inManagedObjectContext:managedObjectContext];
    
    power.powerName = name;
    
    return power;
}

+ (instancetype) fetchPowerInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:powerEntityName];
    select.predicate = [NSPredicate predicateWithFormat:@"%K = %@", powerPropertyName, name];
    
    return [[managedObjectContext executeFetchRequest:select error:NULL] firstObject];
}


@end
