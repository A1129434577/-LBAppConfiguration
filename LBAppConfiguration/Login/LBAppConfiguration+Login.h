//
//  LBAppConfiguration+Login.h
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration.h"
#import <LBUserInfo/LBUserModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBAppConfiguration (Login)

/// 用户尝试登录切换主界面
/// @param newInfo 当info不为空的时候表示需要重新覆盖保存账号和token等用户信息
/// @param alias 激光推送别名
/// @param tags 激光推送标签
+(void)tryLoginWithNewLoginInfo:(nullable NSDictionary<LBUserModelKey,id> *)newInfo
                     jPushAlias:(nullable NSString *)alias
                      jPushTags:(nullable NSSet<NSString *> *)tags;

/// 用户退出登录成功切换主界面
+(void)loginOut;

/// 清空JPush设置和用户密码，保留用户账号
+(void)cleanJPushSettingAndUserInfoHoldBackAccount;
@end

NS_ASSUME_NONNULL_END
