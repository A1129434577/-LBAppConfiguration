//
//  LBAppConfiguration+Notifications.h
//  LBAppConfiguration
//
//  Created by 刘彬 on 2021/2/3.
//

#import "LBAppConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LBNotificationsDelegate <NSObject>
@optional
/// 当用户点击推送/本地消息时的回调
/// @param notificationInfo 消息
-(void)handleNotification:(nullable NSDictionary *)notificationInfo;

/// 配置消息推送（比如设置别名、tag等）
-(void)pushNotificationsConfig;

/// 清空消息推送配置（比如删除别名、tag等）
-(void)cleanPushNotificationsConfig;
@end


@interface LBAppConfiguration (Notifications)
@property (nonatomic, weak) id<LBNotificationsDelegate> notificationDelegate;
@end

NS_ASSUME_NONNULL_END
