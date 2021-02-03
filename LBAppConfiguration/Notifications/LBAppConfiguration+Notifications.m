//
//  LBAppConfiguration+Notifications.m
//  LBAppConfiguration
//
//  Created by 刘彬 on 2021/2/3.
//

#import "LBAppConfiguration+Notifications.h"
#import <objc/runtime.h>

static NSString *LBNotificationDelegateKey = @"LBNotificationDelegateKey";

@implementation LBAppConfiguration (Notifications)
-(void)setNotificationDelegate:(id<LBNotificationsDelegate>)notificationDelegate{
    objc_setAssociatedObject(self, &LBNotificationDelegateKey, notificationDelegate, OBJC_ASSOCIATION_ASSIGN);
}
-(id<LBNotificationsDelegate>)notificationDelegate{
    return objc_getAssociatedObject(self, &LBNotificationDelegateKey);
}
@end
