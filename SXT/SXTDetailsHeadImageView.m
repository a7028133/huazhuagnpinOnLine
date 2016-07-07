//
//  SXTDetailsHeadImageView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsHeadImageView.h"

@interface SXTDetailsHeadImageView()<SDCycleScrollViewDelegate>

@property (strong, nonatomic)   UILabel *numberLabel;                 /** 显示已经卖掉的个数 */

@end

@implementation SXTDetailsHeadImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.numberLabel];
    }
    return self;
}
- (void)layoutSubviews{
    WS(weakSelf);
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(90, 22));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-30);
        make.right.equalTo(weakSelf.mas_right).offset(11);
    }];
}
- (void)setHaveBug:(NSString *)haveBug{
    self.numberLabel.text = [NSString stringWithFormat:@"%@",haveBug];
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.layer.cornerRadius = 11.0;
        _numberLabel.font = [UIFont systemFontOfSize:11.0];
        _numberLabel.backgroundColor = RGB(238, 74, 47);
        [_numberLabel setTextColor:[UIColor whiteColor]];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (SDCycleScrollView *)headImage{
    if (!_headImage) {
        _headImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230) delegate:self placeholderImage:[UIImage imageNamed:@"桌面"]];
        _headImage.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headImage.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _headImage;
}
@end
