//
//  LBAppConfiguration+Login.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+Login.h"
#import "NSObject+LBTopViewController.h"
#import "JPUSHService.h"
#import "LBUIMacro.h"
#import <objc/runtime.h>

static NSString *LBTouristPatternKey = @"LBTouristPatternKey";
static NSString *LBModalPresentationStyleKey = @"LBModalPresentationStyleKey";


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
    if ([self shareInstanse].touristPattern) {
        UIViewController *loginVC = [self findLoginViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController];
        if (loginVC.navigationController) {
            loginVC = loginVC.navigationController;
        }
        if (loginVC.presentingViewController) {
            loginVC = loginVC.presentingViewController;
        }
        if (loginVC) {
            [loginVC dismissViewControllerAnimated:YES completion:NULL];
        }else{
            if ([self shareInstanse].homeNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].homeVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeVCClass alloc] init];
            }
        }
    }
    else{
        if ([LBUserModel shareInstanse].userInfo[LBToken] &&
            [LBUserModel shareInstanse].userInfo[LBAccount]) {//复用此token（免登陆）
            if ([self shareInstanse].homeNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].homeVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeVCClass alloc] init];
            }
        }else{
            if ([self shareInstanse].loginNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].loginNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].loginVCClass alloc] init];
            }
        }
    }
    
}
+ (void)loginOutCleanUserInfo{
    [self cleanJPushSettingAndUserInfoHoldBackAccount:NO];
    [self loginOut];
}

+(void)loginOutHoldBackAccount{
    [self cleanJPushSettingAndUserInfoHoldBackAccount:YES];
    [self loginOut];
}
+(void)loginOut{
    UIViewController *loginVC;
    if ([self shareInstanse].loginNaVCClass) {
        loginVC = [[[self shareInstanse].loginNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
    }else{
        loginVC = [[[self shareInstanse].loginVCClass alloc] init];
    }
    if ([self shareInstanse].touristPattern) {
        UIViewController *topVC = [UIViewController topViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController];
        if (![topVC isKindOfClass:[self shareInstanse].loginVCClass]) {
            loginVC.modalPresentationStyle = ([self shareInstanse].modalPresentationStyle==UIModalPresentationFullScreen)?UIModalPresentationCustom:[self shareInstanse].modalPresentationStyle;
            [topVC presentViewController:loginVC animated:YES completion:NULL];
            loginVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:[self shareInstanse] action:@selector(touristLoginCancel)];
        }
    }else{
        LB_KEY_WINDOW.rootViewController = loginVC;
    }
    
}
+(void)cleanJPushSettingAndUserInfoHoldBackAccount:(BOOL)holdBackAccount{
    if (holdBackAccount) {
        NSString *account = [LBUserModel shareInstanse].userInfo[LBAccount];
        //移除用户数据
        [[LBUserModel shareInstanse] removeUserInfo];
        [[LBUserModel shareInstanse] setLBUserInfoObject:account forKey:LBAccount];
    }
    
    //移除激光推送信息
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:3];
    
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:4];
}


+ (UIViewController *)findLoginViewControllerWithRootViewController:(UIViewController *)rootVC
{
    if ([rootVC isKindOfClass:[self shareInstanse].loginVCClass]) {
        return rootVC;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController*)rootVC;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootVC;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:(UIViewController *)navigationController.topViewController];
    } else if (rootVC.presentedViewController) {
        UIViewController *presentedViewController = (UIViewController *)rootVC.presentedViewController;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:presentedViewController];
    } else {
        return nil;
    }
}

-(void)touristLoginCancel{
    [[UIViewController topViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)touristPattern{
    return [objc_getAssociatedObject(self, &LBTouristPatternKey) boolValue];
}
- (void)setTouristPattern:(BOOL)touristPattern{
    objc_setAssociatedObject(self, &LBTouristPatternKey, @(touristPattern), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIModalPresentationStyle)modalPresentationStyle{
    return [objc_getAssociatedObject(self, &LBModalPresentationStyleKey) integerValue];
}
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    objc_setAssociatedObject(self, &LBModalPresentationStyleKey, @(modalPresentationStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
