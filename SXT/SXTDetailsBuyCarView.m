//
//  SXTDetailsBuyCarView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/12.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsBuyCarView.h"

@implementation SXTDetailsBuyCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addInBuyCarButton];
        [self addSubview:self.buyCarButton];
        [self addSubview:self.buyNowButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_buyCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(26, 26));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(13);
    }];
    
    [_addInBuyCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.buyCarButton.mas_right).offset(34);
        make.height.equalTo(35);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.buyNowButton.mas_left).offset(-15);
    }];
    
    [_buyNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(35);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.width.equalTo(weakSelf.addInBuyCarButton.mas_width);
    }];
    
    
}

- (UIButton *)buyNowButton{
    if (!_buyNowButton) {
        _buyNowButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyNowButton setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [_buyNowButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _buyNowButton.backgroundColor = RGB(66, 181, 244);
        _buyNowButton.layer.masksToBounds = YES;
        _buyNowButton.layer.cornerRadius = 10;
    }
    return _buyNowButton;
}

- (UIButton *)addInBuyCarButton{
    if (!_addInBuyCarButton) {
        _addInBuyCarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addInBuyCarButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
        [_addInBuyCarButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _addInBuyCarButton.backgroundColor = RGB(88, 215, 251);
        _addInBuyCarButton.layer.masksToBounds = YES;
        _addInBuyCarButton.layer.cornerRadius = 10;
    }
    return _addInBuyCarButton;
}


- (UIButton *)buyCarButton{
    if (!_buyCarButton) {
        _buyCarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyCarButton setImage:[UIImage imageNamed:@"详情界面购物车按钮"] forState:(UIControlStateNormal)];
    }
    return _buyCarButton;
}

@end
