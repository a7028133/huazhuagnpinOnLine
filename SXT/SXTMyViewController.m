//
//  SXTMyViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//


//17721025595           123123


#import "SXTMyViewController.h"
#import "SXTMyTableView.h"
#import "SXTMyTableHeadView.h"
#import "SXTLoginViewController.h"
#import "SXTLandingViewController.h"
@interface SXTMyViewController ()

@property (strong, nonatomic)   SXTMyTableView *myTableView;              /** 我的列表 */
@property (strong, nonatomic)   SXTMyTableHeadView *myTableHeadView;              /** 表格头 */


@end

@implementation SXTMyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self judgeIsLogin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.myTableView];
    WS(weakSelf);
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (SXTMyTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[SXTMyTableView alloc]init];
        _myTableView.tableHeaderView = self.myTableHeadView;
        _myTableView.dataArray = @[@{@"title":@"我的收藏",@"image":@"我的界面我的收藏图标"},@{@"title":@"意见反馈",@"image":@"我的界面意见反馈图标"},@{@"title":@"关于我们",@"image":@"我的界面关于我们图标"},@{@"title":@"客服热线",@"image":@"我的界面客服热线图标"},@{@"title":@"我的优惠劵",@"image":@"我的界面我的优惠券图标"},@{@"title":@"邀请好友，立刻赚钱",@"image":@"我的界面邀请好友图标"}];
        WS(weakSelf);
        _myTableView.exitBlock = ^{
            [weakSelf judgeIsLogin];
        };
    }
    return _myTableView;
}

- (SXTMyTableHeadView *)myTableHeadView{
    if (!_myTableHeadView) {
        _myTableHeadView = [[SXTMyTableHeadView alloc]initWithFrame:CGRectMake(0, 0, 300, 125)];
        UIButton *loginBtn = [_myTableHeadView valueForKey:@"loginButton" ];
        [loginBtn addTarget:self action:@selector(loginButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
        UIButton *landingBtn = [_myTableHeadView valueForKey:@"landingButton" ];
        [landingBtn addTarget:self action:@selector(landingButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _myTableHeadView;
}

- (void)loginButtonMethod{
    SXTLoginViewController *login = [[SXTLoginViewController alloc]init];
    login.title = @"登陆";
    [self.navigationController pushViewController:login animated:YES];
}

- (void)landingButtonMethod{
    SXTLandingViewController *landing = [[SXTLandingViewController alloc]init];
    landing.title = @"注册";
    [self.navigationController pushViewController:landing animated:YES];
}

- (void)judgeIsLogin{
    NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    [_myTableHeadView showLandingAndLoginBtn:isLogin];
    [_myTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end



















