//
//  FreakType+Implementation.h
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "FreakType.h"

@interface FreakType (Implementation)

+ (instancetype)fetchInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

+ (instancetype)freakTypeInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

@end
