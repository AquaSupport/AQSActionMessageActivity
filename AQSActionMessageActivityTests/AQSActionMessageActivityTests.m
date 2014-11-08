//
//  AQSActionMessageActivityTests.m
//  AQSActionMessageActivityTests
//
//  Created by kaiinui on 2014/11/09.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>

#import "AQSActionMessageActivity.h"
#import <MessageUI/MessageUI.h>

@interface AQSActionMessageActivity (Test) <MFMessageComposeViewControllerDelegate>

- (BOOL)isAvailableForMessage;
- (BOOL)isAvailableForAttachments;
- (UIViewController *)viewControllerWithComposeViewController:(MFMessageComposeViewController *)viewController;

@end

@interface AQSActionMessageActivityTests : XCTestCase

@property AQSActionMessageActivity *activity;

@end

@implementation AQSActionMessageActivityTests

- (void)setUp {
    [super setUp];
    
    _activity = [[AQSActionMessageActivity alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItsActivityCategoryIsShare {
    XCTAssertTrue(AQSActionMessageActivity.activityCategory == UIActivityCategoryAction);
}

- (void)testItReturnsItsImage {
    XCTAssertNotNil(_activity.activityImage);
}

- (void)testItReturnsItsType {
    XCTAssertTrue([_activity.activityType isEqualToString:@"org.openaquamarine.message.action"]);
}

- (void)testItReturnsItsTitle {
    XCTAssertTrue([_activity.activityTitle isEqualToString:@"Message"]);
}

- (void)testItCanPerformActivityWithTextAndURLWhenEmailIsAvailable {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isAvailableForMessage]).andReturn(YES);
    NSArray *activityItems = @[@"hoge", [NSURL URLWithString:@"http://google.com/"]];
    
    XCTAssertTrue([activity canPerformWithActivityItems:activityItems]);
}

- (void)testItCannotPerformActivityIfEmailIsNotAvailable {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isAvailableForMessage]).andReturn(NO);
    NSArray *activityItems = @[@"hoge", [NSURL URLWithString:@"http://google.com/"]];
    
    XCTAssertFalse([activity canPerformWithActivityItems:activityItems]);
}

- (void)testItReturnsTextSetComposeViewControllerWithText {
    id composeViewControllerMock = [OCMockObject niceMockForClass:[MFMessageComposeViewController class]];
    NSArray *activityItems = @[@"hoge"];
    [_activity prepareWithActivityItems:activityItems];
    
    [[composeViewControllerMock expect] setBody:@"hoge"];
    
    [_activity viewControllerWithComposeViewController:composeViewControllerMock];
    
    [composeViewControllerMock verify];
}

- (void)testItReturnsURLSetComposeViewControllerWithURL {
    id composeViewControllerMock = [OCMockObject niceMockForClass:[MFMessageComposeViewController class]];
    NSArray *activityItems = @[[NSURL URLWithString:@"http://google.com/"]];
    [_activity prepareWithActivityItems:activityItems];
    
    [[composeViewControllerMock expect] setBody:@"http://google.com/"];
    
    [_activity viewControllerWithComposeViewController:composeViewControllerMock];
    
    [composeViewControllerMock verify];
}

- (void)testItReturnsTextAndURLSetComposeViewControllerWithTextAndURL {
    id composeViewControllerMock = [OCMockObject niceMockForClass:[MFMessageComposeViewController class]];
    NSArray *activityItems = @[@"whoa", [NSURL URLWithString:@"http://google.com/"]];
    [_activity prepareWithActivityItems:activityItems];
    
    [[composeViewControllerMock expect] setBody:@"whoa http://google.com/"];
    
    [_activity viewControllerWithComposeViewController:composeViewControllerMock];
    
    [composeViewControllerMock verify];
}

- (void)testItSetsImageAttachmentSetComposeViewControllerWithImageWhenAttachmentAvailable {
    id composeViewControllerMock = [OCMockObject niceMockForClass:[MFMessageComposeViewController class]];
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isAvailableForAttachments]).andReturn(YES);
    NSArray *activityItems = @[[UIImage imageNamed:@"AQSActionMessageActivity"], @"whoa", [NSURL URLWithString:@"http://google.com/"]];
    [_activity prepareWithActivityItems:activityItems];
    
    [[composeViewControllerMock expect] addAttachmentData:[OCMArg any] typeIdentifier:@"image/png" filename:@"image.png"];
    
    [activity viewControllerWithComposeViewController:composeViewControllerMock];
    
    [composeViewControllerMock verify];
}

- (void)testItSetsImageAttachmentSetComposeViewControllerWithImageWhenAttachmentNotAvailable {
    id composeViewControllerMock = [OCMockObject niceMockForClass:[MFMessageComposeViewController class]];
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isAvailableForAttachments]).andReturn(NO);
    NSArray *activityItems = @[[UIImage imageNamed:@"AQSActionMessageActivity"], @"whoa", [NSURL URLWithString:@"http://google.com/"]];
    [_activity prepareWithActivityItems:activityItems];
    
    [[composeViewControllerMock reject] addAttachmentData:[OCMArg any] typeIdentifier:@"image/png" filename:@"image.png"];
    
    [_activity viewControllerWithComposeViewController:composeViewControllerMock];
    
    [composeViewControllerMock verify];
}

- (void)testItInvokesActivityDidFinishWhenComposeMessageViewControllerDelegateCompleted {
    id activity = [OCMockObject partialMockForObject:_activity];
    
    [[activity expect] activityDidFinish:YES];
    
    [activity messageComposeViewController:nil didFinishWithResult:MessageComposeResultSent];
    
    [activity verify];
}

- (void)testItInvokesActivityDidFinishWhenComposeMessageViewControllerDelegateFailed {
    id activity = [OCMockObject partialMockForObject:_activity];
    
    [[activity expect] activityDidFinish:NO];
    
    [activity messageComposeViewController:nil didFinishWithResult:MessageComposeResultFailed];
    
    [activity verify];
}

- (void)testItInvokesActivityDidFinishWhenComposeMessageViewControllerDelegateCancelled {
    id activity = [OCMockObject partialMockForObject:_activity];
    
    [[activity expect] activityDidFinish:NO];
    
    [activity messageComposeViewController:nil didFinishWithResult:MessageComposeResultCancelled];
    
    [activity verify];
}


@end
