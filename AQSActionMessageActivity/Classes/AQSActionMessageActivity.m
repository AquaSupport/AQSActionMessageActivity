//
//  AQSActionMessageActivity.m
//  AQSActionMessageActivity
//
//  Created by kaiinui on 2014/11/09.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQSActionMessageActivity.h"

#import <MessageUI/MessageUI.h>

@interface AQSActionMessageActivity () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSArray *activityItems;
@property (nonatomic, strong) MFMessageComposeViewController *viewController;

@end

@implementation AQSActionMessageActivity

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    [super prepareWithActivityItems:activityItems];
    
    self.activityItems = activityItems;
}

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (NSString *)activityType {
    return @"org.openaquamarine.message.action";
}

- (NSString *)activityTitle {
    return @"Message";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:NSStringFromClass([self class])];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return [self isAvailableForMessage];
}

- (UIViewController *)activityViewController {
    _viewController = [[MFMessageComposeViewController alloc] init];
    return [self viewControllerWithComposeViewController:_viewController];
}

# pragma mark - Helper (Array)

- (NSString *)nilOrFirstStringFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[NSString class]]) {
            return item;
        }
    }
    return nil;
}

- (UIImage *)nilOrFirstImageFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[UIImage class]]) {
            return item;
        }
    }
    return nil;
}

- (NSURL *)nilOrFirstURLFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[NSURL class]]) {
            return item;
        }
    }
    return nil;
}

# pragma mark - Helpers (Message)

- (BOOL)isAvailableForMessage {
    return [MFMessageComposeViewController canSendText];
}

- (BOOL)isAvailableForAttachments {
    return [MFMessageComposeViewController canSendAttachments];
}

- (UIViewController *)viewControllerWithComposeViewController:(MFMessageComposeViewController *)viewController {
    _viewController.messageComposeDelegate = self;

    NSString *text = [self nilOrFirstStringFromArray:_activityItems];
    NSURL *URL = [self nilOrFirstURLFromArray:_activityItems];
    UIImage *image = [self nilOrFirstImageFromArray:_activityItems];
    
    if (!!image && [self isAvailableForAttachments]) {
        [viewController addAttachmentData:UIImagePNGRepresentation(image) typeIdentifier:@"image/jpeg" filename:@"image.png"];
    }
    
    if (!!text && !!URL) {
        [viewController setBody:[NSString stringWithFormat:@"%@ %@", text, URL.absoluteString]];
    } else if(!!URL) {
        [viewController setBody:URL.absoluteString];
    } else if (!!text) {
        [viewController setBody:text];
    }
    
    return viewController;
}

# pragma mark - MFMessageComposeViewController

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self activityDidFinish:(result == MessageComposeResultSent)];
    [self.viewController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
