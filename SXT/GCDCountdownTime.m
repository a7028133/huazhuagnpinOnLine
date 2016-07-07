//
//  GCDCountdownTime.m
//  SXT
//
//  Created by 赵金鹏 on 15/11/24.
//  Copyright © 2015年 赵金鹏. All rights reserved.
//

#import "GCDCountdownTime.h"

@implementation GCDCountdownTime

+ (void)GCDTimeMethod:(UIButton *)countdownBtn{
    __block int timeout= 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //用dispatch_source_create函数来初始化dispatch_source_t
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);//DISPATCH_SOURCE_TYPE_TIMER是dispatch_source_t中的一种定时器
    //设置定时器信息，让定时器每秒都执行(dispatch_walltime用于计算绝对时间，NSEC_PER_SEC是秒数)
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //添加事件处理器，（相当于开启定时器，让它在有效时间内执行）
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（开启按钮的用户交互）
                countdownBtn.userInteractionEnabled = YES;
                NSString * str = [NSString stringWithFormat:@"获取验证码"];
                [countdownBtn setTitle:str forState:(UIControlStateNormal)];
            });
        }else
        {
            //            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒后重新获取验证码",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（在规定时间内关闭按钮的用户交互）
                countdownBtn.userInteractionEnabled = NO;
                NSString * str = [NSString stringWithFormat:@"%ds",timeout];
                [countdownBtn setTitle:str forState:(UIControlStateNormal)];
            });
            timeout--;
        }
    });
    //将计时器挂起
    dispatch_resume(_timer);
}

@end
