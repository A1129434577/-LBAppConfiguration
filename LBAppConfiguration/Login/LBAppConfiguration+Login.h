//
//  LBAppConfiguration+Login.h
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration.h"
#import "LBUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LBAppConfiguration (Login)
@property (nonatomic, assign) BOOL touristPattern;//游客模式，default NO
@property (nonatomic, assign) UIModalPresentationStyle modalPresentationStyle;//游客模式登录界面模态类型，default UIModalPresentationFullScreen

/// 用户尝试登录切换主界面
/// @param newInfo 当info不为空的时候表示需要重新覆盖保存账号和token等用户信息
/// @param alias 激光推送别名
/// @param tags 激光推送标签
+(void)tryLoginWithNewLoginInfo:(nullable NSDictionary<LBUserModelKey,id> *)newInfo
                     jPushAlias:(nullable NSString *)alias
                      jPushTags:(nullable NSSet<NSString *> *)tags;

/// 清除用户信息并退出到登录界面
+(void)loginOutCleanUserInfo;

/// 清除用户信息(保留登录账号)并退出到登录界面
+(void)loginOutHoldBackAccount;

/// 保留用户信息并退出到登录界面
+(void)loginOut;


/// 清空JPush设置和用户信息
/// @param holdBackAccount 是否保留用户账号
+(void)cleanJPushSettingAndUserInfoHoldBackAccount:(BOOL)holdBackAccount;
@end

NS_ASSUME_NONNULL_END
