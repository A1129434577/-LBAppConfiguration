//
//  LBAppConfiguration.h
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBHandleReceivedNotificationDelegate <NSObject>
@optional
-(void)handleNotification:(NSDictionary *)notificationInfo;
@end

@interface LBAppConfiguration : NSObject
@property (nonatomic, strong) NSString *JPushAppKey;
@property (nonatomic, strong) Class loginVCClass;
@property (nonatomic, strong) Class loginNaVCClass;
@property (nonatomic, strong) Class homeVCClass;
@property (nonatomic, strong) Class homeNaVCClass;
@property (nonatomic, weak) id<LBHandleReceivedNotificationDelegate> notificationDelegate;
+(LBAppConfiguration *)shareInstanse;
@end

NS_ASSUME_NONNULL_END
