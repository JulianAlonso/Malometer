//
//  Domain+Implementation.m
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Domain+Implementation.h"

static NSString *const kDomainName = @"domainName";

@implementation Domain (Implementation)

+ (Domain *)fetchInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    select.predicate = [NSPredicate predicateWithFormat:@"%@ like %@",kDomainName, name];
    NSArray *array = [managedObjectContext executeFetchRequest:select error:nil];
    
    if (array.count)
    {
        return array.firstObject;
    }
    
    return nil;
}

+ (Domain *)domainInMOC:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
    Domain *domain = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:managedObjectContext];
    domain.domainName = name;
    
    return domain;
}

@end
