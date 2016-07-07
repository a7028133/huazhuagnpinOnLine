//
//  SXTDetailsAllLabelView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/7.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsAllLabelView.h"
#import "SXTDetailListModel.h"
#import "NSString+Helper.h"

@interface SXTDetailsAllLabelView()

//@property (strong, nonatomic)   <#类名#> *<#控件名#>;              /** <#控件名字#> */

@end

@implementation SXTDetailsAllLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDetailListModel:(NSArray *)detailListModel{
    CGFloat height = [self makeAllLabel:detailListModel];
    if (_labelHeightBlock) {
        _labelHeightBlock(height);
    }
}

- (CGFloat)makeAllLabel:(NSArray *)dataArray{
    
    CGFloat heitht = 10;
    
    CGFloat valueLabelWidth = VIEW_WIDTH - 100;
    
    for (SXTDetailListModel *model in dataArray) {
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, heitht, 60, 12)];
        titleLabel.text = model.Title;
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc]init];
        CGFloat valueHeight = [NSString autoHeightWithString:model.Value Width:valueLabelWidth Font:[UIFont systemFontOfSize:12.0]];
        valueLabel.frame = CGRectMake(84, heitht, valueLabelWidth, valueHeight);
        valueLabel.text = model.Value;
        valueLabel.font = [UIFont systemFontOfSize:12.0];
        valueLabel.textAlignment = NSTextAlignmentLeft;
        valueLabel.textColor = [UIColor blackColor];
        [self addSubview:valueLabel];
        
        heitht = heitht + valueHeight + 15;
    }
    return heitht;
}

@end





