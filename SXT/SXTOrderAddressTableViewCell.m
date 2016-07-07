//
//  SXTOrderAddressTableViewCell.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTOrderAddressTableViewCell.h"

@interface SXTOrderAddressTableViewCell()

@property (strong, nonatomic)   UIImageView *backImageView;              /** 背景图片 */
@property (strong, nonatomic)   UIImageView *addressImage;              /** 地址图标 */
@property (strong, nonatomic)   UILabel *consigneeLabel;              /** 收货人 */
@property (strong, nonatomic)   UILabel *addressLabel;              /** 收货地址 */
@property (strong, nonatomic)   UILabel *telephoneNumber;              /** 电话 */
@end

@implementation SXTOrderAddressTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.backImageView];
        [self addSubview:self.addressImage];
        [self addSubview:self.consigneeLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.telephoneNumber];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(weakSelf);
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [_addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(24, 24));
        make.left.equalTo(15);
    }];
    
    [_consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(16);
        make.left.equalTo(weakSelf.addressImage.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(130, 15));
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_bottom).offset(7);
        make.right.equalTo(weakSelf.mas_right).offset(-30);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.addressImage.mas_right).offset(10);
    }];
    
    [_telephoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.consigneeLabel.mas_right);
        make.top.equalTo(weakSelf.consigneeLabel.mas_top);
        make.height.equalTo(15);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
    }];
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"地址背景"]];;
    }
    return _backImageView;
}

- (UIImageView *)addressImage{
    if (!_addressImage) {
        _addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"位置"]];
    }
    return _addressImage;
}

- (UILabel *)consigneeLabel{
    if (!_consigneeLabel) {
        _consigneeLabel = [[UILabel alloc]init];
        _consigneeLabel.textColor = RGB(50, 50, 50);
        _consigneeLabel.font = [UIFont systemFontOfSize:15.0];
        _consigneeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _consigneeLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = RGB(50, 50, 50);
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}

- (UILabel *)telephoneNumber{
    if (!_telephoneNumber) {
        _telephoneNumber = [[UILabel alloc]init];
        _telephoneNumber.textColor = RGB(50, 50, 50);
        _telephoneNumber.font = [UIFont systemFontOfSize:15.0];
    }
    return _telephoneNumber;
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
