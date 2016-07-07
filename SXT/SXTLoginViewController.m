//
//  SXTLoginViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

//   17721025595        123123

#import "SXTLoginViewController.h"
#import "SXTThirdLoginView.h"
#import "SXTLoginView.h"
#import "SXTLandingViewController.h"
#import "SXTUMThirdLoginTool.h"
@interface SXTLoginViewController ()

@property (strong, nonatomic)   SXTThirdLoginView *thirdLoginView;  /** 第三方view */
@property (strong, nonatomic)   SXTLoginView *loginView;              /** 登陆view */
@end

@implementation SXTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    self.view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.thirdLoginView];
    [self addLayoutIn];
    // Do any additional setup after loading the view.
}

- (void)addLayoutIn{
    WS(weakSelf);
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(15);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(180);
    }];
    
    [_thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(85);
    }];
}
//登录上面两个文本输入框的VIEW
- (SXTLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[SXTLoginView alloc]init];
        WS(weakSelf);
        _loginView.loginBlock = ^(NSDictionary *dict){
            //在获得参数字典以后去调用网络请求
            [weakSelf loginViewMethod:dict];
        };
        _loginView.landingBlock = ^(){
            [weakSelf pushToLandingMethod];
        };
    }
    return _loginView;
}

- (void)pushToLandingMethod{
    SXTLandingViewController *landing = [[SXTLandingViewController alloc]init];
    [self.navigationController pushViewController:landing animated:YES];
}

- (SXTThirdLoginView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView = [[SXTThirdLoginView alloc]init];
        __weak typeof (self) weakSelf = self;
        _thirdLoginView.QQLoginBlock = ^(){
            [weakSelf qqLoginMethod];
        };
    }
    return _thirdLoginView;
}

//登陆请求
- (void)loginViewMethod:(NSDictionary *)dict{
    WS(weakSelf);
    [self getDataFromSever:@"appMember/appLogin.do"
                 parameter:dict
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     //登陆成功的block回调
                     NSDictionary *dic = project;
                     if ([dic[@"ErrorMessage"] isEqualToString:@"登陆成功"]) {
                         [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"ISLOGIN"];
                         self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",dic[@"result"]];
                         [weakSelf.navigationController popViewControllerAnimated:YES];
                     }else{
                         //登陆失败的block回调
                         [weakSelf showTostView:dic[@"ErrorMessage"]];
                     }
                     
                     
                     
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

- (void)qqLoginMethod{
    [SXTUMThirdLoginTool qqLoginMethod:self success:^(NSDictionary *dict) {
        NSLog(@"dict : %@",dict);
    } loginError:^{
        NSLog(@"登陆失败");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


















