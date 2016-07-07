//
//  SXTDetailsAllImageView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/7.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageHeightBlock)(CGFloat height);

@interface SXTDetailsAllImageView : UIView

@property (strong, nonatomic)   NSArray *imageArray;
@property (copy, nonatomic)     imageHeightBlock imageBlock;    /** 返回高度的black*/
@end
