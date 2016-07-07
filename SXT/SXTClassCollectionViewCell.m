//
//  SXTClassCollectionViewCell.m
//  SXT
//
//  Created by 赵金鹏 on 16/5/2.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTClassCollectionViewCell.h"

@interface SXTClassCollectionViewCell()
@property (strong, nonatomic)   UIImageView *iconImageView;              /** 商品图片 */
@end


@implementation SXTClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

- (void)setRecommendModel:(SXTClassCollectionModel *)recommendModel{
    [_iconImageView downloadImage:recommendModel.ImgView place:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

@end






