//
//  SXTThirdLoginView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTThirdLoginView.h"

@interface SXTThirdLoginView()

@property (strong, nonatomic)   UILabel *lineLabel;              /** 横线label */
@property (strong, nonatomic)   UILabel *tostLabel;              /** 提示lable */
@property (strong, nonatomic)   UIButton *qqButton;              /** qq */
@property (strong, nonatomic)   UIButton *sinaButton;              /** 新浪 */
@property (strong, nonatomic)   UIButton *wxButton;              /** 微信 */

@end


@implementation SXTThirdLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineLabel];
        [self addSubview:self.tostLabel];
        [self addSubview:self.qqButton];
        [self addSubview:self.wxButton];
        [self addSubview:self.sinaButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.top.equalTo(weakSelf.mas_top).offset(10);
    }];
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.lineLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(85, 16));
        make.centerX.equalTo(weakSelf.lineLabel.mas_centerX);
    }];
    
    [_wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(45, 45));
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom).offset(20);
    }];
    
    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(45, 45));
        make.right.equalTo(weakSelf.wxButton.mas_left).offset(-(VIEW_WIDTH-135)/4);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom).offset(20);
    }];
    
    [_sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(45, 45));
        make.left.equalTo(weakSelf.wxButton.mas_right).offset((VIEW_WIDTH-135)/4);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom).offset(20);
    }];
    
    
    
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(229, 229, 229);
    }
    return _lineLabel;
}

- (UILabel *)tostLabel{
    if (!_tostLabel) {
        _tostLabel = [[UILabel alloc]init];
        _tostLabel.text = @"一键登录";
        _tostLabel.font = [UIFont systemFontOfSize:15.0];
        _tostLabel.textAlignment = NSTextAlignmentCenter;
        _tostLabel.backgroundColor = RGB(245, 245, 245);
        _tostLabel.textColor = RGB(206, 206, 206);
    }
    return _tostLabel;
}

- (UIButton *)qqButton{
    if (!_qqButton) {
        _qqButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_qqButton setImage:[UIImage imageNamed:@"登录界面qq登陆"] forState:(UIControlStateNormal)];
        [_qqButton addTarget:self action:@selector(qqButtonLoginMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _qqButton;
}

- (void)qqButtonLoginMethod{
    if (_QQLoginBlock) {
        _QQLoginBlock();
    }
}

- (UIButton *)sinaButton{
    if (!_sinaButton) {
        _sinaButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sinaButton setImage:[UIImage imageNamed:@"登陆界面微博登录"] forState:(UIControlStateNormal)];
    }
    return _sinaButton;
}

- (UIButton *)wxButton{
    if (!_wxButton) {
        _wxButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_wxButton setImage:[UIImage imageNamed:@"登录界面微信登录"] forState:(UIControlStateNormal)];
    }
    return _wxButton;
}
@end












