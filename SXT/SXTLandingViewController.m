//
//  SXTLandingViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTLandingViewController.h"
#import "SXTLandingView.h"
#import "SXTThirdLoginView.h"
#import "SXTLandingNextViewController.h"
@interface SXTLandingViewController ()

@property (strong, nonatomic)   SXTLandingView *LandingView;              /** 注册view */
@property (strong, nonatomic)   SXTThirdLoginView *thirdLoginView;  /** 第三方view */
@end

@implementation SXTLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    self.view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.LandingView];
    [self.view addSubview:self.thirdLoginView];
    [self addLayoutIn];
    // Do any additional setup after loading the view.
}

- (void)addLayoutIn{
    WS(weakSelf);
    [_LandingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(15);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(215);
    }];
    
    [_thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.LandingView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(85);
    }];
}

- (SXTLandingView *)LandingView{
    if (!_LandingView) {
        _LandingView = [[SXTLandingView alloc]init];
        WS(weakSelf);
        _LandingView.landingBlock = ^(NSDictionary *dict){
            [weakSelf pushToNextViewController:dict];
        };
        _LandingView.loginBlock = ^(){
            [weakSelf popToLoginView];
        };
    }
    return _LandingView;
}

- (SXTThirdLoginView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView = [[SXTThirdLoginView alloc]init];
    }
    return _thirdLoginView;
}

- (void)popToLoginView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToNextViewController:(NSDictionary *)dict{
    SXTLandingNextViewController *next = [[SXTLandingNextViewController alloc]init];
    next.parameterDic = dict;
    [self.navigationController pushViewController:next animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
