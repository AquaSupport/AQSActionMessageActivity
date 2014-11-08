AQSActionMessageActivity
========================

![](http://img.shields.io/cocoapods/v/AQSActionMessageActivity.svg?style=flat) [![Build Status](https://travis-ci.org/AquaSupport/AQSActionMessageActivity.svg?branch=master)](https://travis-ci.org/AquaSupport/AQSActionMessageActivity)

[iOS] UIActivity class for Message that appears in Action in UIActivityViewController

Usage
---

```objc
UIActivity *textActivity = [[AQSActionMessageActivity alloc] init];

UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:textActivity];
activityViewController.excludedActivityTypes = @[UIActivityTypeMessage];

[self presentViewController:activityViewController animated:YES completion:NULL];
```

Accepted `activityItems` Types
---

- `NSString` for message body
- `NSURL` for message body
- `UIImage` when attachments is available in SMS Service

And any combinations of them.

Can perform activity when
---

- When SMS Service is available

It appears in `UIActivityViewController` even if you provide empty `activityItem` for the situation that the user compose the message by themself.

Installation
---

```
pod "AQSActionMessageActivity"
```

Link to Documents
---

https://dl.dropboxusercontent.com/u/7817937/___doc___AQSActionMessageActivity/html/index.html

Related Projects
---

- [AQSShareService](https://github.com/AquaSupport/AQSShareService) - UX-improved sharing feature in few line. 
