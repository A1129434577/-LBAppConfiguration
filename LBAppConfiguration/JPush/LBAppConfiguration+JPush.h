//
//  LBAppConfiguration+JPush.h
//  YaoHe2.0
//
//  Created by 刘彬 on 2020/11/27.
//

#import "LBAppConfiguration.h"
#import "LBUserModel.h"
#import "LBAppConfiguration+Notifications.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


NS_ASSUME_NONNULL_BEGIN

extern NSString *const LBUserRemoteNotificationsSwitchOff;

@interface LBAppConfiguration (JPush)<JPUSHRegisterDelegate>
@property (nonatomic, copy)   NSString *jpushKey;
@property (nonatomic, strong) Class appDelegateClass;
@end

NS_ASSUME_NONNULL_END
