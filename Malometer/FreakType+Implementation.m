//
//  FreakType+Implementation.m
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "FreakType+Implementation.h"

static NSString *const kFreakTypeName = @"freakTypeName";

@implementation FreakType (Implementation)


+ (instancetype)fetchInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    select.predicate = [NSPredicate predicateWithFormat:@"%k == %@", kFreakTypeName, name];
    NSArray *types = [managedObjectContext executeFetchRequest:select error:nil];
    
    if (types.count)
    {
        return types.firstObject;
    }
    
    return nil;
}

+ (instancetype)freakTypeInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    FreakType *freakType = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:managedObjectContext];

    if (freakType)
    {
        freakType.freakTypeName = name;
    }
    
    return freakType;
}


@end
