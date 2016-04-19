//
//  ViewController.m
//  TouchID
//
//  Created by 陈天宇 on 16/4/18.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import "ViewController.h"
#import "TYTouchID.h"

@interface ViewController ()<TYTouchIDDelegate>
@property (strong, nonatomic) UILabel *touchIDState;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.touchIDState];
    self.touchIDState.text = @"开始验证TouchID";
}

- (UILabel *)touchIDState {
    if (!_touchIDState) {
        _touchIDState = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 150, 44)];
        _touchIDState.textAlignment = NSTextAlignmentCenter;
        _touchIDState.textColor = [UIColor purpleColor];
    }
    return _touchIDState;
}

- (IBAction)touchID:(id)sender {
    TYTouchID *touchID = [TYTouchID sharedTouchID];
    [touchID authenticationTouchIDWithLocalizedReason:@"我的TouchID" touchIDDelegate:self];
    
}

- (void)touchIDAuthenticationSuccess {
    NSLog(@"success");
    self.touchIDState.text = @"success";
}

- (void)touchIDAuthenticationFailure {
    NSLog(@"failure");
    self.touchIDState.text = @"failure";
}

- (void)touchIDAuthenticationUserCancel {
    NSLog(@"user cancel");
    self.touchIDState.text = @"user cancel";
}

- (void)touchIDAuthenticationUserFallback {
    NSLog(@"user fallback");
    self.touchIDState.text = @"user fallback";
}

- (void)touchIDAuthenticationUserSystemCancel {
    NSLog(@"user system cancel");
    self.touchIDState.text = @"user system cancel";
}

- (void)touchIDAuthenticationPasscodeNotSet {
    NSLog(@"passcode not set");
    self.touchIDState.text = @"passcode not set";
}

- (void)touchIDAuthenticationTouchIDNotAvailable {
    NSLog(@"touchID not available");
    self.touchIDState.text = @"touchID not available";
}

- (void)touchIDAuthenticationTouchIDNotEnrolled {
    NSLog(@"touchID not enrolled");
    self.touchIDState.text = @"touchID not enrolled";
}

- (void)touchIDAuthenticationTouchIDLockout {
    NSLog(@"touchID Lockout");
    self.touchIDState.text = @"touchID Lockout";
}

- (void)touchIDAuthenticationAppCancel {
    NSLog(@"app cancel");
    self.touchIDState.text = @"app cancel";
}

- (void)touchIDAuthenticationInvalidContext {
    NSLog(@"invalid context");
    self.touchIDState.text = @"invalid context";
}

- (void)touchIDAuthenticationDeviceNotSupport {
    NSLog(@"device not support");
    self.touchIDState.text = @"device not support";
}


@end
