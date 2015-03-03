//
//  Agent+Implementation.m
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Agent+Implementation.h"

static NSString *const kAgentMotivation = @"agentMotivation";
static NSString *const kAgentDestructionPower = @"agentDestructionPower";
static NSString *const kAgentApprisal = @"agentApprisal";

@implementation Agent (Implementation)

+ (NSSet *)keyPathsForValuesAffectingAppraisal
{
    return [NSSet setWithArray:@[kAgentMotivation, kAgentDestructionPower]];
}

- (NSNumber *)agentAppraisal
{
    if (![self primitiveValueForKey:kAgentApprisal])
    {
        [self calculateAppraisal];
    }
    
    [self willAccessValueForKey:kAgentApprisal];
    NSNumber *returnNumber =  [self primitiveValueForKey:kAgentApprisal];
    [self didAccessValueForKey:kAgentApprisal];
    
    return returnNumber;
}

- (void)calculateAppraisal
{
    [self willChangeValueForKey:kAgentApprisal];
    [self setPrimitiveValue:@((self.agentDestructionPower.integerValue + self.agentMotivation.integerValue) / 2)
                     forKey:kAgentApprisal];
    [self didChangeValueForKey:kAgentApprisal];
}

@end
