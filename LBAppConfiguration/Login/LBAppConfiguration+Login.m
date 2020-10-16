//
//  LBAppConfiguration+Login.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+Login.h"
#import <JPush/JPUSHService.h>
#import <LBCommonComponents/LBUIMacro.h>

@implementation LBAppConfiguration (Login)
+(void)tryLoginWithNewLoginInfo:(NSDictionary<LBUserModelKey,id> *)newInfo
                     jPushAlias:(NSString *)alias
                      jPushTags:(NSSet<NSString *> *)tags{
    if (newInfo) {
        //保存账号和token
        [[LBUserModel shareInstanse] setLBUserInfoObject:newInfo[LBToken] forKey:LBToken];
        [[LBUserModel shareInstanse] setLBUserInfoObject:newInfo[LBAccount] forKey:LBAccount];
    }
    //设置激光推送
    if (alias) {
        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        }  seq:1];
    }
    if (tags) {
        [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
        } seq:2];
    }
    if ([LBUserModel shareInstanse].userInfo[LBToken] &&
        [LBUserModel shareInstanse].userInfo[LBAccount]) {//复用此token（免登陆）
        if ([[self shareInstanse].homeVCClass isKindOfClass:UITabBarController.class]) {
            LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeVCClass alloc] init];
        }else{
            LB_KEY_WINDOW.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[[self shareInstanse].homeVCClass alloc] init]];
        }
    }else{
        LB_KEY_WINDOW.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
    }
}

+(void)loginOut{
    [self cleanJPushSettingAndUserInfoHoldBackAccount];
    
    LB_KEY_WINDOW.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
}
+(void)cleanJPushSettingAndUserInfoHoldBackAccount{
    NSString *account = [LBUserModel shareInstanse].userInfo[LBAccount];
    //移除用户数据
    [[LBUserModel shareInstanse] removeUserInfo];
    [[LBUserModel shareInstanse] setLBUserInfoObject:account forKey:LBAccount];
    
    //移除激光推送信息
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:3];
    
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:4];
}
@end
