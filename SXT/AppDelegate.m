//
//  AppDelegate.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "SXTTabBarController.h"

#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

@end
//com.bjyskj.haveFace
//com.SXTqwe.peng
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //570de95fe0f55ac532000e86
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    SXTTabBarController *SXTTabBar = [[SXTTabBarController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = SXTTabBar;
    
    [self.window makeKeyWindow];

    
    
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//     NSDictionary *islogin = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
//    if (islogin.count == 0) {
//        [[NSUserDefaults standardUserDefaults]setValue:@"noLogin" forKey:@"ISLOGIN"];
//    }
    return YES;
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UMSocialSnsService  applicationDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
