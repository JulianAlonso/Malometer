//
//  Power+Implementation.h
//  Malometer
//
//  Created by Julian Alonso on 5/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Power.h"

@interface Power (Implementation)

+ (instancetype) powerInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

+ (instancetype) fetchPowerInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

@end
