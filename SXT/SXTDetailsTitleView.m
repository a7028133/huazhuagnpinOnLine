//
//  SXTDetailsTitleView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsTitleView.h"
#import "NSString+Helper.h"
#import "NSMutableAttributedString+Helper.h"
@interface SXTDetailsTitleView()

@property (strong, nonatomic)   UILabel *titleLabel;              /** 标题文本框 */
@property (strong, nonatomic)   UILabel *priceLabel;              /** 价格 */
@property (strong, nonatomic)   UILabel *lineLabel;              /** 分割线label */
@property (strong, nonatomic)   UILabel *describeLabel;              /** 描述文字label */
@property (strong, nonatomic)   UIImageView *brandImage;              /** 品牌图标 */
@property (strong, nonatomic)   UILabel *brandLabel;              /** 品牌名字 */
@property (strong, nonatomic)   UIImageView *countryImage;              /** 国旗 */
@property (strong, nonatomic)   UILabel *countryLabel;              /** 国家名字 */
@property (strong, nonatomic)   UILabel *backLabel1;              /** 浅灰色背景1 */
@property (strong, nonatomic)   UILabel *backLabel2;              /** 浅灰色背景2 */
@property (strong, nonatomic)   UILabel *tostLabel;              /** 图文详情label */
@property (strong, nonatomic)   UILabel *lineLabel2;              /** 底部分割线label */
@end

@implementation SXTDetailsTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.describeLabel];
        [self addSubview:self.backLabel1];
        [self addSubview:self.whiteButton];
        [self addSubview:self.brandImage];
        [self addSubview:self.brandLabel];
        [self addSubview:self.countryImage];
        [self addSubview:self.countryLabel];
        [self addSubview:self.backLabel2];
        [self addSubview:self.tostLabel];
        [self addSubview:self.lineLabel2];
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    //标题约束
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-30);
        make.left.equalTo(weakSelf.mas_left).offset(30);
    }];
    //价格约束
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(27);
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(weakSelf.mas_left);
        make.height.equalTo(22);
    }];
    //第一条分割细线
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(26);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.height.equalTo(1);
    }];
    //商品描述约束
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(16);
        make.right.equalTo(weakSelf.mas_right).offset(-16);
    }];
    //宽背景lable
    [_backLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.describeLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 10));
    }];
    
    [_whiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backLabel1.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 80));
    }];
    
    [_brandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(weakSelf.whiteButton.mas_centerY);
        make.left.equalTo(16);
    }];
    
    [_brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.brandImage.mas_top).offset(5);
        make.left.equalTo(weakSelf.brandImage.mas_right).offset(16);
        make.height.equalTo(14);
        make.right.equalTo(weakSelf.mas_right).offset(-30);
    }];
    
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.brandImage.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.brandImage.mas_right).offset(16);
        make.size.equalTo(CGSizeMake(18, 13));
    }];
    
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.countryImage.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.countryImage.mas_centerY);
        make.height.offset(13);
        make.right.equalTo(weakSelf.mas_right).offset(-30);
    }];
    
    [_backLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 10));
        make.top.equalTo(weakSelf.whiteButton.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
    }];
    
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.top.equalTo(weakSelf.backLabel2.mas_bottom).offset(18);
        make.size.equalTo(CGSizeMake(70, 15));
    }];
    
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tostLabel.mas_bottom).offset(18);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.height.equalTo(1);
    }];
}

- (void)setInformationModel:(SXTFindGoodsDetailModel *)informationModel{
    _informationModel = informationModel;
    //设置标题文本
    _titleLabel.text = informationModel.Abbreviation;
    CGFloat titleLabelHeight = [NSString autoHeightWithString:informationModel.Abbreviation Width:VIEW_WIDTH-60 Font:[UIFont boldSystemFontOfSize:19.0]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(titleLabelHeight);
    }];
    //设置消费文本
    _priceLabel.attributedText = [NSMutableAttributedString makeStrikethroughAttributedString:informationModel.Price:informationModel.OriginalPrice rebateString:informationModel.Discount];
    //商品描述
    CGFloat describeHeight = [NSString autoHeightWithString:informationModel.GoodsIntro Width:VIEW_WIDTH-32 Font:[UIFont systemFontOfSize:12.0]];
    
    _describeLabel.text = informationModel.GoodsIntro;
    //将商品描述的约束补全，或者进行约束更新
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(describeHeight);
    }];
    [_brandImage downloadImage:informationModel.ShopImage place:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
    _brandLabel.text = informationModel.BrandCNName;
    _countryLabel.text = informationModel.CountryName;
    //将计算后的高度返回
    if (_heightBlock) {
        _heightBlock(280+titleLabelHeight+describeHeight);
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
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

- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.numberOfLines = 0;
        _describeLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _describeLabel;
}

- (UILabel *)backLabel1{
    if (!_backLabel1) {
        _backLabel1 = [[UILabel alloc]init];
        _backLabel1.backgroundColor = RGB(245, 245, 245);
    }
    return _backLabel1;
}

- (UIButton *)whiteButton{
    if (!_whiteButton) {
        _whiteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _whiteButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _whiteButton;
}

- (UIImageView *)brandImage{
    if (!_brandImage) {
        _brandImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"桌面"]];
        
    }
    return _brandImage;
}

- (UILabel *)brandLabel{
    if (!_brandLabel) {
        _brandLabel = [[UILabel alloc]init];
        _brandLabel.textAlignment = NSTextAlignmentLeft;
        _brandLabel.font = [UIFont systemFontOfSize:13.0];
        _brandLabel.textColor = RGB(23, 23, 23);
    }
    return _brandLabel;
}

- (UIImageView *)countryImage{
    if (!_countryImage) {
        _countryImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"桌面"]];
    }
    return _countryImage;
}

- (UILabel *)countryLabel{
    if (!_countryLabel) {
        _countryLabel = [[UILabel alloc]init];
        _countryLabel.textAlignment = NSTextAlignmentLeft;
        _countryLabel.font = [UIFont systemFontOfSize:13.0];
        _countryLabel.textColor = RGB(23, 23, 23);
    }
    return _countryLabel;
}

- (UILabel *)backLabel2{
    if (!_backLabel2) {
        _backLabel2 = [[UILabel alloc]init];
        _backLabel2.backgroundColor = RGB(245, 245, 245);
    }
    return _backLabel2;
}

- (UILabel *)tostLabel{
    if (!_tostLabel) {
        _tostLabel = [[UILabel alloc]init];
        _tostLabel.text = @"图文详情";
        _tostLabel.font = [UIFont systemFontOfSize:15.0];
        _tostLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tostLabel;
}

- (UILabel *)lineLabel2{
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc]init];
        _lineLabel2.backgroundColor = RGB(245, 245, 245);
    }
    return _lineLabel2;
}
@end















