//
//  AppDelegate.m
//  LBAppConfigurationExample
//
//  Created by 刘彬 on 2020/10/16.
//

#import "AppDelegate.h"

#import "LBAppConfiguration+JPush.h"


@interface AppDelegate ()<LBUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置消息推送的代理（本地和远程推送通用）
    [LBAppConfiguration shareInstanse].notificationDelegate = self;
    
    //如果您的项目正好使用极光推送，那么可以这样设置快速集成极光推送
    [LBAppConfiguration setAppDelegateClass:self.class jPushKey:@"08d54656edf68d60e50629c0"];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}

#pragma mark LBNotificationsDelegate
- (void)pushNotificationsConfig{
    //比如设置激光推送别名
    [JPUSHService setAlias:@"1129434577" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    }  seq:1];
}

-(void)cleanPushNotificationsConfig{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:3];
}

-(void)didReceiveRemoteNotification:(NSDictionary *)notificationInfo{
    NSLog(@"收到推送消息");
}

-(void)handleRemoteNotification:(NSDictionary *)notificationInfo{
    NSLog(@"点击了推送消息");
}
@end
