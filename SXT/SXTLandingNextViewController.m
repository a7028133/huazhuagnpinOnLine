//
//  SXTLandingNextViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTLandingNextViewController.h"
#import "SXTLandingNextView.h"
#import "GCDCountdownTime.h"

@interface SXTLandingNextViewController ()

@property (strong, nonatomic)   SXTLandingNextView *nextView;              /** 输入框view */

@end

@implementation SXTLandingNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    self.view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.nextView];
    [self addLayoutIn];
    [self requestVerification];
    // Do any additional setup after loading the view.
}

- (void)addLayoutIn{
    WS(weakSelf);
    [_nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(180);
    }];
}

- (SXTLandingNextView *)nextView{
    if (!_nextView) {
        _nextView = [[SXTLandingNextView alloc]init];
        [_nextView.referButton addTarget:self action:@selector(requestVerification) forControlEvents:(UIControlEventTouchUpInside)];
        [_nextView.landingButton addTarget:self action:@selector(landingMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nextView;
}
//发送短信验证码到手机
- (void)requestVerification{//appMember/createSeekPwdCode.do?Telephone=17721025595
    WS(weakSelf);
/**
 *http://123.57.141.249:8080/beautalk/appMember/createCode.do
 *请求方式为post，请求参数MemberId：参数内容为注册页面输入的手机号
 */
    
    
    [self postDataFromSever:@"appMember/createCode.do"
                 parameter:@{@"MemberId":_parameterDic[@"LoginName"]}
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     NSDictionary *dic = project;
                     if ([dic[@"result"] isEqual:@"success"]) {
                         [weakSelf GCDTimeMethod];
                     }
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//注册用户时调用的网络请求，请求需要四个参数，一个参数是用户名（手机号），一个参数是短信验证码，一个参数为登陆密码，还需要再添加一遍手机号
- (void)landingMethod{
    
    [self getDataFromSever:@"appMember/appRegistration.do"
                 parameter:[self makeLandingParameter]
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     NSDictionary *dic = project;
                     if ([dic[@"result"] isEqual:@"success"]) {
                         [self showTostView:@"注册成功"];
                     }
                 } isError:^(NSURLSessionDataTask *task, NSError *error) {
                     
                 }];
}
- (NSDictionary *)makeLandingParameter{
    
    return @{@"LoginName":_parameterDic[@"LoginName"],@"Lpassword":_parameterDic[@"Lpassword"],@"Code":_nextView.verificationText.text,@"Telephone":_parameterDic[@"LoginName"]};
}
//短信倒计时
- (void)GCDTimeMethod{
    __block NSInteger timeout= 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.nextView.referButton.userInteractionEnabled = YES;
                self.nextView.timeLabel.text = @"验证码";
            });
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.nextView.referButton.userInteractionEnabled = NO;
                self.nextView.timeLabel.text = [NSString stringWithFormat:@"%li秒后重试",timeout];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end







