//
//  Domain.h
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent;

@interface Domain : NSManagedObject

@property (nonatomic, retain) NSString * domainName;
@property (nonatomic, retain) NSSet *domainAgents;
@end

@interface Domain (CoreDataGeneratedAccessors)

- (void)addDomainAgentsObject:(Agent *)value;
- (void)removeDomainAgentsObject:(Agent *)value;
- (void)addDomainAgents:(NSSet *)values;
- (void)removeDomainAgents:(NSSet *)values;

@end
