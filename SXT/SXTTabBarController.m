//
//  SXTTabBarController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTTabBarController.h"
#import "SXTNavigationController.h"

@interface SXTTabBarController()

@property (strong, nonatomic)   NSArray *viewControllersArray;

@end
@implementation SXTTabBarController

- (NSArray *)viewControllersArray{
    if (!_viewControllersArray) {
        _viewControllersArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SXTTabBarControllers" ofType:@"plist"]];
    }
    return _viewControllersArray;
}

- (void)viewDidLoad{
    NSMutableArray *controllersArray = [NSMutableArray arrayWithCapacity:self.viewControllersArray.count];
    
    [self.viewControllersArray enumerateObjectsUsingBlock:^(NSDictionary *dict,
                                                            NSUInteger idx,
                                                            BOOL * _Nonnull stop)
    {
        
        Class viewControllerClass = NSClassFromString(dict[@"ViewController"]);
        
        UIViewController *viewController = [[viewControllerClass alloc]init];
        
        viewController.title = dict[@"Title"];
        
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:dict[@"TabbarSelectItemImage"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        viewController.tabBarItem.image = [[UIImage imageNamed:dict[@"TabbarItemImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        SXTNavigationController *navigation = [[SXTNavigationController alloc]initWithRootViewController:viewController];
        
        [controllersArray addObject:navigation];
        
    }];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0],
                                                        NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : RGB(65, 179, 241)} forState:(UIControlStateSelected)];

    self.viewControllers = controllersArray;
    
    self.selectedIndex = 0;
    
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_back"]];
}



@end



