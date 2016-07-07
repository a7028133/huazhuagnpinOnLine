//
//  SXTMyTableHeadView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/18.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTMyTableHeadView.h"

@interface SXTMyTableHeadView()

@property (strong, nonatomic)   UIImageView *backImage;                 /** 背景图片 */
@property (strong, nonatomic)   UIButton *loginButton;                  /** 登陆按钮 */
@property (strong, nonatomic)   UIButton *landingButton;                /** 注册按钮 */
@property (strong, nonatomic)   UIImageView *iconImage;                 /** 头像 */
@property (strong, nonatomic)   UILabel *userNameLabel;                 /** 用户名字 */
@property (strong, nonatomic)   UILabel *gradeLabel;                    /** 等级 */

@end



@implementation SXTMyTableHeadView

- (void)showLandingAndLoginBtn:(NSDictionary *)dic{
    if (dic.count != 0) {
        _iconImage.hidden = NO;
        _userNameLabel.hidden = NO;
        _gradeLabel.hidden = NO;
        _loginButton.hidden = YES;
        _landingButton.hidden = YES;
        _userNameLabel.text = dic[@"MemberName"];
        _gradeLabel.text = dic[@"MemberLvl"];
    }else{
        _iconImage.hidden = YES;
        _userNameLabel.hidden = YES;
        _gradeLabel.hidden = YES;
        _loginButton.hidden = NO;
        _landingButton.hidden = NO;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImage];
        [self addSubview:self.loginButton];
        [self addSubview:self.landingButton];
        [self addSubview:self.iconImage];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.gradeLabel];
        self.backgroundColor = [UIColor redColor];
        NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
        [self showLandingAndLoginBtn:isLogin];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(-50);
        make.size.equalTo(CGSizeMake(90, 20));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_landingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(50);
        make.size.equalTo(CGSizeMake(90, 20));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(75, 75));
        make.left.equalTo(60);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(40);
        make.top.equalTo(weakSelf.iconImage.mas_top).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.height.equalTo(15);
    }];
    
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.iconImage.mas_bottom).offset(-10);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(40);
        make.height.equalTo(15);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
    }];
    
}

- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的背景"]];
    }
    return _backImage;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    }
    return _loginButton;
}

- (UIButton *)landingButton{
    if (!_landingButton) {
        _landingButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_landingButton setTitle:@"注 册" forState:(UIControlStateNormal)];
        [_landingButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
    return _landingButton;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"登陆界面微博登录"]];
    }
    return _iconImage;
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:16.0];
        _userNameLabel.textColor = [UIColor whiteColor];
    }
    return _userNameLabel;
}

- (UILabel *)gradeLabel{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc]init];
        _gradeLabel.textColor = [UIColor whiteColor];
        _gradeLabel.font = [UIFont systemFontOfSize:16.0];
        _gradeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _gradeLabel;
}




@end

















