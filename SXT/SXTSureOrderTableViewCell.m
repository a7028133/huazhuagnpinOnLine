//
//  SXTSureOrderTableViewCell.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTSureOrderTableViewCell.h"

@interface SXTSureOrderTableViewCell()

@property (strong, nonatomic)   UIImageView *iconImage;              /** 商品图片 */
@property (strong, nonatomic)   UILabel *titleLabel;              /** 名字 */
@property (strong, nonatomic)   UILabel *priceLabel;              /** 价格 */
@property (strong, nonatomic)   UILabel *lineLabel;              /** 分割线 */
@end

@implementation SXTSureOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.lineLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(22);
        make.height.equalTo(30);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-25);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-25);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-15);
        make.height.equalTo(15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(30);
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(1);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(1);
    }];
}

- (void)setOrderCellrModel:(SXTBuyCarModel *)orderCellrModel{
    [_iconImage downloadImage:orderCellrModel.ImgView place:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
    _titleLabel.text = orderCellrModel.GoodsTitle;
    _priceLabel.text = [NSString stringWithFormat:@"%.2lf x %li",orderCellrModel.Price,orderCellrModel.GoodsCount];
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = RGB(100, 100, 100);
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(245, 245, 245);
    }
    return _lineLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
