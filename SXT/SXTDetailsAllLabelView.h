//
//  SXTDetailsAllLabelView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/7.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LabelHeightBlock)(CGFloat height);

@interface SXTDetailsAllLabelView : UIView

@property (strong, nonatomic)   NSArray *detailListModel;     /** 存储数据模型的数组 */
@property (copy, nonatomic) LabelHeightBlock labelHeightBlock;  /** 返回高度的block*/
@end
