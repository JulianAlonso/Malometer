//
//  Agent+Implementation.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "Agent.h"

@interface Agent (Implementation)

+ (instancetype)agentInMOC:(NSManagedObjectContext *)managedObjectContext andName:(NSString *)name;

@end

@interface Agent (FetchRequest)

+ (NSFetchRequest *)fetchAllAgents;

@end
