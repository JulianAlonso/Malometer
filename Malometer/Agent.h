//
//  Agent.h
//  Malometer
//
//  Created by Julian Alonso on 5/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Domain, FreakType;

@interface Agent : NSManagedObject

@property (nonatomic, retain) NSNumber * agentAppraisal;
@property (nonatomic, retain) NSNumber * agentDestructionPower;
@property (nonatomic, retain) NSNumber * agentMotivation;
@property (nonatomic, retain) NSString * agentName;
@property (nonatomic, retain) NSString * agentPower;
@property (nonatomic, retain) FreakType *agentCategory;
@property (nonatomic, retain) NSSet *agentDomain;
@end

@interface Agent (CoreDataGeneratedAccessors)

- (void)addAgentDomainObject:(Domain *)value;
- (void)removeAgentDomainObject:(Domain *)value;
- (void)addAgentDomain:(NSSet *)values;
- (void)removeAgentDomain:(NSSet *)values;

@end
