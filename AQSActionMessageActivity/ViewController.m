//
//  ViewController.m
//  AQSActionMessageActivity
//
//  Created by kaiinui on 2014/11/09.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "ViewController.h"

#import "AQSActionMessageActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIActivity *activity = [[AQSActionMessageActivity alloc] init];
    NSArray *items = @[
                       @"body",
                       [NSURL URLWithString:@"http://google.com/"]
                       ];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:@[activity]];
    
    [self presentViewController:activityViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
