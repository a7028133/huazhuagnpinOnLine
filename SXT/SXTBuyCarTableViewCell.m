//
//  SXTBuyCarTableViewCell.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTBuyCarTableViewCell.h"

@interface SXTBuyCarTableViewCell()

@property (strong, nonatomic)   UIImageView *iconImage;              /** 图片 */
@property (strong, nonatomic)   UILabel *titleLabel;              /** 标题 */
@property (strong, nonatomic)   UILabel *priceLabel;              /** 价格 */
@property (strong, nonatomic)   UIImageView *backImage;              /** 背景图片 */
@property (strong, nonatomic)   UILabel *lineLabel;              /** 分割线 */
@end


@implementation SXTBuyCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.backImage];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.cutButton];
        [self.contentView addSubview:self.lineLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(13);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(53, 53));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.selectButton.mas_right).offset(6);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(14);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.height.equalTo(14);
        make.top.equalTo(weakSelf.iconImage.mas_top);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(14);
        make.right.equalTo(weakSelf.backImage.mas_left).offset(-15);
        make.height.equalTo(13);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-22);
    }];
    
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-14);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-15);
        make.size.equalTo(CGSizeMake(85, 25));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backImage.mas_centerY);
        make.centerX.equalTo(weakSelf.backImage.mas_centerX);
        make.size.equalTo(CGSizeMake(35, 25));
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.top.equalTo(weakSelf.backImage.mas_top);
        make.right.equalTo(weakSelf.backImage.mas_right);
    }];
    
    [_cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.top.equalTo(weakSelf.backImage.mas_top);
        make.left.equalTo(weakSelf.backImage.mas_left);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-1);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(1);
    }];
    
}

- (void)setBuyCarModel:(SXTBuyCarModel *)BuyCarModel{
    _BuyCarModel = BuyCarModel;
    
    [_iconImage downloadImage:BuyCarModel.ImgView place:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
    _titleLabel.text = BuyCarModel.GoodsTitle;
    _priceLabel.text = [NSString stringWithFormat:@"%.2lf",BuyCarModel.Price];
    _countLabel.text = [NSString stringWithFormat:@"%li",BuyCarModel.GoodsCount];
    _selectButton.selected = BuyCarModel.isSelectButton;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectButton setImage:[UIImage imageNamed:@"购物车界面商品未选中"] forState:(UIControlStateNormal)];
        [_selectButton setImage:[UIImage imageNamed:@"购物车界面商品选中对号按钮"] forState:(UIControlStateSelected)];
        _selectButton.selected = YES;
    }
    return _selectButton;
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
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:12.0];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addButton.backgroundColor = [UIColor clearColor];
    }
    return _addButton;
}
- (UIButton *)cutButton{
    if (!_cutButton) {
        _cutButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cutButton.backgroundColor = [UIColor clearColor];
    }
    return _cutButton;
}
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"购物车界面商品加减按钮"]];
    }
    return _backImage;
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
}

@end











