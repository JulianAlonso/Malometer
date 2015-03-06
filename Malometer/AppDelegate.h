//
//  AppDelegate.h
//  Malometer
//
//  Created by Julian Alonso on 2/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, nonatomic, strong) NSManagedObjectContext *rootManagedObjectContext;
@property (readonly, nonatomic, strong) NSManagedObjectContext *backgroundManagedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

