//
//  SceneDelegate.m
//  LBAppConfigurationExample
//
//  Created by 刘彬 on 2020/10/16.
//

#import "SceneDelegate.h"

#import "LBAppConfiguration+Login.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    if ([windowScene isKindOfClass:UIWindowScene.class] == NO) {
        return;
    }
    
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    //设置登录控制器类
    [LBAppConfiguration shareInstanse].loginVCClass = LoginViewController.class;
    //如果需要设置登录导航控制器类
    [LBAppConfiguration shareInstanse].loginNaVCClass = UINavigationController.class;
    //设置主界面类
    [LBAppConfiguration shareInstanse].homeVCClass = TabBarViewController.class;
    //如果需要设置主界面导航控制器类
    //[LBAppConfiguration shareInstanse].homeVCNaClass = UINavigationController.class;
    //是否支持游客模式
    [LBAppConfiguration shareInstanse].touristPattern = YES;
    //开始登录，loginInfo为基本用户信息，内部会依据此信息判断是否是已登录状态
    [LBAppConfiguration tryLoginWithNewLoginInfo:nil];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}
@end
