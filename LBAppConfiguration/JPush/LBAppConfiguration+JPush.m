//
//  LBAppConfiguration+JPush.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+JPush.h"

#ifdef DEBUG
#define JPUSH_TYPE 0
#else
#define JPUSH_TYPE 1
#endif

@implementation LBAppConfiguration (JPush)
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JPush_ApplicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JPush_ApplicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}
+(void)JPush_ApplicationWillEnterForeground{
    //清空消息通知数量提醒
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
+(void)JPush_ApplicationDidFinishLaunching:(NSNotification *)notification{
    [self JPush_ApplicationWillEnterForeground];
    
    NSDictionary *launchOptions = notification.userInfo;
    // 3.0.0及以后版本注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
      entity.types =
        JPAuthorizationOptionAlert|
        JPAuthorizationOptionBadge|
        JPAuthorizationOptionSound|
        JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
      entity.types =
        JPAuthorizationOptionAlert|
        JPAuthorizationOptionBadge|
        JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:[self shareInstanse]];
    
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:[self shareInstanse].JPushAppKey
                          channel:@"App Store"
                 apsForProduction:JPUSH_TYPE
            advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    
    if ([self.notificationDelegate respondsToSelector:@selector(handleNotification:)]) {
        [self.notificationDelegate handleNotification:userInfo];
    }
    
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    }else{
        NSLog(@"iOS10 前台收到本地通知::%@",userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    if ([self.notificationDelegate respondsToSelector:@selector(handleNotification:)]) {
        [self.notificationDelegate handleNotification:userInfo];
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
    }else{
        NSLog(@"iOS10 收到本地通知::%@",userInfo);
    }
    completionHandler();  // 系统要求执行这个方法
    
    if ([self.notificationDelegate respondsToSelector:@selector(handleNotification:)]) {
        [self.notificationDelegate handleNotification:userInfo];
    }
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    NSLog(@"receive notification authorization status:%lu, info:%@", status, info);
}

#endif

#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification  API_AVAILABLE(ios(12.0)){
  if (notification) {
      NSLog(@"从通知界面直接进入应用");
  }else{
      NSLog(@"从系统设置界面进入应用");
  }
}
#endif
@end
