//
//  Domain+Implementation.h
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Domain.h"

@interface Domain (Implementation)

+ (Domain *)fetchInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

+ (Domain *)domainInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

@end
