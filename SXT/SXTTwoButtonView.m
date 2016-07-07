//
//  SXTTwoButtonView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/2.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTTwoButtonView.h"
#import "Masonry.h"
@implementation SXTTwoButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.singleButton];
        [self addSubview:self.groupBuyButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    
    [_singleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.equalTo(VIEW_WIDTH/2);
    }];
    
    [_groupBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.equalTo(VIEW_WIDTH/2);
    }];
}

- (UIButton *)singleButton{
    if (!_singleButton) {
        _singleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_singleButton setImage:[UIImage imageNamed:@"新品团未选中"] forState:(UIControlStateNormal)];
        [_singleButton setImage:[UIImage imageNamed:@"新品团选中"] forState:(UIControlStateSelected)];
        //对button的显示的图片添加便宜量
        [_singleButton setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [_singleButton setTitle:@"新品团购" forState:(UIControlStateNormal)];
        [_singleButton setTitleColor:RGB(67, 182, 241) forState:(UIControlStateNormal)];
        [_singleButton setTitleColor:RGB(239, 101, 48) forState:(UIControlStateSelected)];
        _singleButton.selected = YES;
    }
    return _singleButton;
}

- (UIButton *)groupBuyButton{
    if (!_groupBuyButton) {
        _groupBuyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_groupBuyButton setImage:[UIImage imageNamed:@"品牌团未选中"] forState:(UIControlStateNormal)];
        [_groupBuyButton setImage:[UIImage imageNamed:@"品牌团选中"] forState:(UIControlStateSelected)];
        [_groupBuyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [_groupBuyButton setTitle:@"品牌团购" forState:(UIControlStateNormal)];
        [_groupBuyButton setTitleColor:RGB(67, 182, 241) forState:(UIControlStateNormal)];
        [_groupBuyButton setTitleColor:RGB(239, 101, 48) forState:(UIControlStateSelected)];
    }
    return _groupBuyButton;
}


@end







