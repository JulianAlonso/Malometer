//
//  AppDelegateTest.m
//  Malometer
//
//  Created by Julian Alonso on 3/3/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface AppDelegateTest : XCTestCase
{
    AppDelegate *sut;
}

@end

@implementation AppDelegateTest

- (void)setUp
{
    [super setUp];
    [self createSUT];
}

- (void)tearDown
{
    [self releaseSut];
    [super tearDown];
}

- (void)testExample
{
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample
{

    [self measureBlock:^{

    }];
}

- (void)testNotNil
{
    XCTAssertNotNil(sut, @"Sut must not be nil");
}

- (void)releaseSut
{
    sut = nil;
}


- (void)createSUT
{
    sut = [[AppDelegate alloc] init];
}

@end
