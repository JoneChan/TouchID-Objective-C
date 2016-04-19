//
//  TYTouchID.m
//  TouchID
//
//  Created by 陈天宇 on 16/4/18.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import "TYTouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <UIKit/UIKit.h>

@implementation TYTouchID

static TYTouchID *touchID;

+ (instancetype)sharedTouchID {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        touchID = [[self alloc] init];
    });
    return touchID;
}

- (void)authenticationTouchIDWithLocalizedReason:(NSString *)localizedReason touchIDDelegate:(id<TYTouchIDDelegate>)delegate {
    NSAssert(localizedReason != nil, @"localizedReason 不能为空");
    self.touchIDDelegate = delegate;
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) { // 设置支持TouchID
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            if (success) { // touchID验证成功
                if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationSuccess)]) {
                    [self.touchIDDelegate touchIDAuthenticationSuccess];
                }
            } else if (error) {
                switch (error.code) {
                    case LAErrorAuthenticationFailed: // 验证失败
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationFailure)]) {
                            [self.touchIDDelegate touchIDAuthenticationFailure];
                        }
                        break;
                        
                    case LAErrorUserCancel: // 用户取消
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationUserCancel)]) {
                            [self.touchIDDelegate touchIDAuthenticationUserCancel];
                        }
                        break;
                        
                    case LAErrorUserFallback: // 用户改换输入密码的方式进行验证
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationUserFallback)]) {
                            [self.touchIDDelegate touchIDAuthenticationUserFallback];
                        }
                        break;
                        
                    case LAErrorSystemCancel:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationUserSystemCancel)]) {
                            [self.touchIDDelegate touchIDAuthenticationUserSystemCancel];
                        }
                        break;
                        
                    case LAErrorPasscodeNotSet:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationPasscodeNotSet)]) {
                            [self.touchIDDelegate touchIDAuthenticationPasscodeNotSet];
                        }
                        break;
                        
                    case LAErrorTouchIDNotAvailable:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationTouchIDNotAvailable)]) {
                            [self.touchIDDelegate touchIDAuthenticationTouchIDNotAvailable];
                        }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationTouchIDNotEnrolled)]) {
                            [self.touchIDDelegate touchIDAuthenticationTouchIDNotEnrolled];
                        }
                        break;
                        
                    case LAErrorTouchIDLockout:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationTouchIDLockout)]) {
                            [self.touchIDDelegate touchIDAuthenticationTouchIDLockout];
                        }
                        break;
                        
                    case LAErrorAppCancel:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationAppCancel)]) {
                            [self.touchIDDelegate touchIDAuthenticationAppCancel];
                        }
                        break;
                        
                    case LAErrorInvalidContext:
                        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationInvalidContext)]) {
                            [self.touchIDDelegate touchIDAuthenticationInvalidContext];
                        }
                        break;
                    default:
                        break;
                }
            }
        }];
    } else {
        if ([self.touchIDDelegate respondsToSelector:@selector(touchIDAuthenticationDeviceNotSupport)]) {
            [self.touchIDDelegate touchIDAuthenticationDeviceNotSupport];
        }
    }
}


@end
