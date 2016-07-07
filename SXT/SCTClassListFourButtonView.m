//
//  SCTClassListFourButtonView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/12.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SCTClassListFourButtonView.h"

@interface SCTClassListFourButtonView()

@property (strong, nonatomic)   UILabel *lineLabel;              /** 蓝线label */

@end

@implementation SCTClassListFourButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotButton];
        [self addSubview:self.priceButton];
        [self addSubview:self.goodButton];
        [self addSubview:self.newsButton];
        [self addSubview:self.lineLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(VIEW_WIDTH/4, 30));
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
    }];
    
    [_priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(VIEW_WIDTH/4, 30));
        make.left.equalTo(weakSelf.hotButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
    }];
    
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(VIEW_WIDTH/4, 30));
        make.left.equalTo(weakSelf.priceButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
    }];
    
    [_newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(VIEW_WIDTH/4, 30));
        make.left.equalTo(weakSelf.goodButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
    }];
    
}

- (UIButton *)hotButton{
    if (!_hotButton) {
        _hotButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _hotButton.backgroundColor = [UIColor whiteColor];
        [_hotButton setTitle:@"热门" forState:(UIControlStateNormal)];
        [_hotButton setTitleColor:RGB(165, 165, 165) forState:(UIControlStateNormal)];
        [_hotButton setTitleColor:RGB(71, 188, 245) forState:(UIControlStateSelected)];
        _hotButton.tag = 1001;
        [_hotButton addTarget:self action:@selector(fourButtonTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
        _hotButton.selected = YES;
    }
    return _hotButton;
}

- (UIButton *)priceButton{
    if (!_priceButton) {
        _priceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _priceButton.backgroundColor = [UIColor whiteColor];
        [_priceButton setTitle:@"价格" forState:(UIControlStateNormal)];
        [_priceButton setTitleColor:RGB(165, 165, 165) forState:(UIControlStateNormal)];
        [_priceButton setTitleColor:RGB(71, 188, 245) forState:(UIControlStateSelected)];
        _priceButton.tag = 1002;
        [_priceButton addTarget:self action:@selector(fourButtonTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _priceButton;
}

- (UIButton *)goodButton{
    if (!_goodButton) {
        _goodButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _goodButton.backgroundColor = [UIColor whiteColor];
        [_goodButton setTitle:@"好评" forState:(UIControlStateNormal)];
        [_goodButton setTitleColor:RGB(165, 165, 165) forState:(UIControlStateNormal)];
        [_goodButton setTitleColor:RGB(71, 188, 245) forState:(UIControlStateSelected)];
        _goodButton.tag = 1003;
        [_goodButton addTarget:self action:@selector(fourButtonTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _goodButton;
}

- (UIButton *)newsButton{
    if (!_newsButton) {
        _newsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _newsButton.backgroundColor = [UIColor whiteColor];
        [_newsButton setTitle:@"新品" forState:(UIControlStateNormal)];
        [_newsButton setTitleColor:RGB(165, 165, 165) forState:(UIControlStateNormal)];
        [_newsButton setTitleColor:RGB(71, 188, 245) forState:(UIControlStateSelected)];
        _newsButton.tag = 1004;
        [_newsButton addTarget:self action:@selector(fourButtonTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _newsButton;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDTH/4/2-20, 28, 40, 2)];
        _lineLabel.backgroundColor = RGB(71, 188, 245);
    }
    return _lineLabel;
}

- (void)fourButtonTouchMethod:(UIButton *)sender{
    
    sender.selected = YES;
    NSString *parameterString = @"host";
    switch (sender.tag) {
        case 1001:{
            parameterString = @"host";
            _priceButton.selected = NO;
            _goodButton.selected = NO;
            _newsButton.selected = NO;
        }
            break;
        case 1002:{
            parameterString = @"price";
            _hotButton.selected = NO;
            _goodButton.selected = NO;
            _newsButton.selected = NO;
        }
            break;
        case 1003:{
            parameterString = @"time";
            _hotButton.selected = NO;
            _priceButton.selected = NO;
            _newsButton.selected = NO;
        }
            break;
        case 1004:{
            parameterString = @"score";
            _hotButton.selected = NO;
            _priceButton.selected = NO;
            _goodButton.selected = NO;
        }
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _lineLabel.frame;
        rect.origin.x = sender.frame.origin.x + sender.frame.size.width/2 - 20;
        _lineLabel.frame = rect;
    }];
    [self makeParameterDictionary:parameterString];
}

- (void)makeParameterDictionary:(NSString *)string{
    NSDictionary *parameterDic = @{@"OrderName":string,@"OrderType":@"DESC"};
    if (_parameterDictionary) {
        _parameterDictionary(parameterDic);
    }
}
@end






