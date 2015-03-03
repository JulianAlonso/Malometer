//
//  Agent+Implementation.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Agent+Implementation.h"

static NSString *const kAgentName = @"agentName";
static NSString *const kAgentMotivation = @"agentMotivation";
static NSString *const kAgentDestructionPower = @"agentDestructionPower";
static NSString *const kAgentAppraisal = @"agentAppraisal";

@implementation Agent (Implementation)

+ (NSSet *)keyPathsForValuesAffectingAppraisal
{
    return [NSSet setWithArray:@[kAgentMotivation, kAgentDestructionPower]];
}

- (NSNumber *)agentAppraisal
{
    [self calculateAppraisal];
    
    [self willAccessValueForKey:kAgentAppraisal];
    NSNumber *returnNumber =  [self primitiveValueForKey:kAgentAppraisal];
    [self didAccessValueForKey:kAgentAppraisal];
    
    return returnNumber;
}

- (void)calculateAppraisal
{
    [self willChangeValueForKey:kAgentAppraisal];
    
    [self setPrimitiveValue:@((self.agentDestructionPower.integerValue + self.agentMotivation.integerValue) / 2)
                     forKey:kAgentAppraisal];
    
    [self didChangeValueForKey:kAgentAppraisal];
}

@end

@implementation Agent (FetchRequest)

+ (NSFetchRequest *)fetchAllAgents
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([self class])];
    fetchRequest.fetchBatchSize = 20;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kAgentName ascending:NO]];
    return fetchRequest;
}

+ (NSFetchRequest *)fetchAllAgentsSortedBy:(NSArray *)sortDescriptors
{
    NSFetchRequest *select = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([self class])];
    select.fetchBatchSize = 20;
    select.sortDescriptors = @[sortDescriptors];
    
    return select;
}

@end
