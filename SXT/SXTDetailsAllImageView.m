//
//  SXTDetailsAllImageView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/7.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsAllImageView.h"
#import "SXTFindGoodsImgListModel.h"
@implementation SXTDetailsAllImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    
    if (_imageBlock) {
        _imageBlock([self makeAllDetailsImage:imageArray]);
    }
}

- (CGFloat)makeAllDetailsImage:(NSArray *)imageArray{
    float height = 0;
    
    
    for (SXTFindGoodsImgListModel *imageModel in imageArray) {
        if ([imageModel.ImgType isEqual:@"1"]) {
            NSArray *sizeArray = [imageModel.Resolution componentsSeparatedByString:@"*"];
            CGFloat imageHeight = [sizeArray[1] floatValue]*(VIEW_WIDTH/[sizeArray[0] floatValue]);
            UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, VIEW_WIDTH, imageHeight)];
            
            [detailImage downloadImage:imageModel.ImgView place:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
            [self addSubview:detailImage];
            height += imageHeight;
        }
    }
    return height;
}

@end
