//
//  SXTGroupBuyTableViewCell.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/2.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTGroupBuyTableViewCell.h"
#import "UIImageView+SDWebImage.h"

@interface SXTGroupBuyTableViewCell()

/**
 品牌团购用来显示的图片
 */
@property (strong, nonatomic)   UIImageView *groupImage;

@end

@implementation SXTGroupBuyTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.groupImage];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf);
    [_groupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setGroupBuyModel:(SXTTimerGroupBuyModel *)groupBuyModel{
    [_groupImage downloadImage:groupBuyModel.ImgView place:[UIImage imageNamed:@"桌面"]];
}

- (UIImageView *)groupImage{
    if (!_groupImage) {
        _groupImage = [[UIImageView alloc]init];
    }
    return _groupImage;
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
