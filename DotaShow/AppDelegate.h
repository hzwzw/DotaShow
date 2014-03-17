//
//  AppDelegate.h
//  DotaShow
//
//  Created by Jianqiang Meng on 3/13/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)sessionStateChanged:(FBSession *)seesion state:(FBSessionState)state error:(NSError *)error;

@end
