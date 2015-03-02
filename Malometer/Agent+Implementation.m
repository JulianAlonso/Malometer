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

- (void)setAgentDestructionPower:(NSNumber *)agentDestructionPower
{
    [self willChangeValueForKey:kAgentDestructionPower];
    [self setPrimitiveValue:agentDestructionPower forKey:@"agentMotivation"];
    [self didChangeValueForKey:kAgentDestructionPower];
}

- (void)setAgentMotivation:(NSNumber *)agentMotivation
{
    [self willChangeValueForKey:kAgentMotivation];
    [self setPrimitiveValue:agentMotivation forKey:@"agentMotivation"];
    [self didChangeValueForKey:kAgentMotivation];
}

- (NSNumber *)agentAppraisal
{
    if (![self primitiveValueForKey:kAgentApprisal])
    {
        [self calculateAppraisal];
    }
    return [self primitiveValueForKey:kAgentApprisal];
}

- (void)calculateAppraisal
{
    [self setPrimitiveValue:@((self.agentDestructionPower.integerValue + self.agentMotivation.integerValue) / 2)
                     forKey:kAgentApprisal];
}

@end
