//
//  TYTouchID.h
//  TouchID
//
//  Created by 陈天宇 on 16/4/18.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TYTouchIDDelegate <NSObject>

@required

/**
 *  touchID验证成功
 */
- (void)touchIDAuthenticationSuccess;

/**
 *  touchID验证失败
 */
- (void)touchIDAuthenticationFailure;

@optional

/**
 *  用户点击了取消按钮
 */
- (void)touchIDAuthenticationUserCancel;

/**
 *  用户选择采用输入密码的方式进行验证
 */
- (void)touchIDAuthenticationUserFallback;

/**
 *  在验证过程中系统取消验证（其他应用进入前台）
 */
- (void)touchIDAuthenticationUserSystemCancel;

/**
 *  用户未设置密码
 */
- (void)touchIDAuthenticationPasscodeNotSet;

/**
 *  设备的TouchID无效
 */
- (void)touchIDAuthenticationTouchIDNotAvailable;

/**
 *  设备未设置TouchID
 */
- (void)touchIDAuthenticationTouchIDNotEnrolled;

/**
 *  多次使用TouchID失败，TouchID被锁
 */
- (void)touchIDAuthenticationTouchIDLockout;

/**
 *  App取消（电话...）
 */
- (void)touchIDAuthenticationAppCancel;

/**
 *  无效的上下文
 */
- (void)touchIDAuthenticationInvalidContext;

/**
 *  设备不支持
 */
- (void)touchIDAuthenticationDeviceNotSupport;

@end

@interface TYTouchID : NSObject

@property (weak, nonatomic) id<TYTouchIDDelegate> touchIDDelegate;

+ (instancetype)sharedTouchID;

/**
 *  TouchID验证
 */
- (void)authenticationTouchIDWithLocalizedReason:(NSString *)localizedReason touchIDDelegate:(id<TYTouchIDDelegate>)delegate;

@end
