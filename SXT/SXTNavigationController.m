//
//  SXTNavigationController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTNavigationController.h"

@implementation SXTNavigationController

// nav的设置只需要设置一次即可， 保证只初始化一次(initialize方法当第一次使用这个类时会调用一次)
+ (void)initialize {
    // 获取UINavigationBar
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置navBar背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
    //设置nav是否为半透明或者透明
//    navBar.translucent = NO;
    // 设置navBar的背景颜色
//    [navBar setBarTintColor:[UIColor whiteColor]];
//    navBar.barTintColor = [UIColor whiteColor];
    // 设置导航栏标题颜色为白色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : RGB(0, 0, 0),
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                     }];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, 0, 30, 30);
        [button setImage:[UIImage imageNamed:@"详情界面返回按钮"] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(returnViewController) forControlEvents:(UIControlEventTouchUpInside)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (void)returnViewController{
    [self popViewControllerAnimated:YES];
}


@end
