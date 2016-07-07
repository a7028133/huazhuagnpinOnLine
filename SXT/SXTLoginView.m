//
//  SXTLoginView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTLoginView.h"

@interface SXTLoginView()<UITextFieldDelegate>

@property (strong, nonatomic)   UILabel *backLabel;              /** 背景 */
@property (strong, nonatomic)   UILabel *lineLabel;              /** 中间线label */
@property (strong, nonatomic)   UITextField *userNameText;              /** 用户名text */
@property (strong, nonatomic)   UITextField *passwordText;              /** 密码text */
@property (strong, nonatomic)   UIButton *loginButton;              /** 登陆按钮 */
@property (strong, nonatomic)   UIButton *landingButton;              /** 注册button */

@end


@implementation SXTLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.userNameText];
        [self addSubview:self.passwordText];
        [self addSubview:self.loginButton];
        [self addSubview:self.landingButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).offset(-1);
        make.right.equalTo(weakSelf.mas_right).offset(1);
        make.height.equalTo(88);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.backLabel.mas_right).offset(-15);
        make.height.equalTo(1);
        make.centerY.equalTo(weakSelf.backLabel.mas_centerY);
    }];
    
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backLabel.mas_top);
        make.left.equalTo(weakSelf.backLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.backLabel.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.lineLabel.mas_top);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom);
        make.left.equalTo(weakSelf.backLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.backLabel.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.backLabel.mas_bottom);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.backLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.backLabel.mas_right).offset(-15);
        make.height.equalTo(35);
    }];
    
    [_landingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginButton.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.size.equalTo(CGSizeMake(80, 22));
    }];
    
}

- (UILabel *)backLabel{
    if (!_backLabel) {
        _backLabel = [[UILabel alloc]init];
        _backLabel.backgroundColor = [UIColor whiteColor];
        _backLabel.layer.borderWidth = 1.0;
        _backLabel.layer.borderColor = RGB(200, 198, 104).CGColor;
    }
    return _backLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(200, 198, 104);
    }
    return _lineLabel;
}

- (UITextField *)userNameText{
    if (!_userNameText) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.delegate = self;
        _userNameText.placeholder = @"输入手机号";
        _userNameText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _userNameText;
}

- (UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        _passwordText.delegate = self;
        _passwordText.secureTextEntry = YES;
        _passwordText.placeholder = @"输入密码";
    }
    return _passwordText;
}


- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginButton.backgroundColor = RGB(67, 182, 245);
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5.0;
        [_loginButton setTitle:@"登  录" forState:(UIControlStateNormal)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_loginButton addTarget:self action:@selector(loginButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginButton;
}

- (UIButton *)landingButton{
    if (!_landingButton) {
        _landingButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_landingButton setTitle:@"免费注册" forState:(UIControlStateNormal)];
        [_landingButton setTitleColor:RGB(67, 182, 245) forState:(UIControlStateNormal)];
        _landingButton.backgroundColor = [UIColor clearColor];
        [_landingButton addTarget:self action:@selector(landingButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }

    return _landingButton;
}

- (void)loginButtonMethod{
    
    if (_loginBlock) {
        _loginBlock(@{@"LoginName":_userNameText.text,@"Lpassword":_passwordText.text});
    }
}

- (void)landingButtonMethod{
    if (_landingBlock) {
        _landingBlock();
    }
}
@end

















