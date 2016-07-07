//
//  SXTDetailsTitleView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTFindGoodsDetailModel.h"/*商品信息model*/
typedef void(^returnHeight)(CGFloat height);

@interface SXTDetailsTitleView : UIView

@property (strong, nonatomic)   UIButton *whiteButton;              /** 白色背景 */
@property (strong, nonatomic)   SXTFindGoodsDetailModel *informationModel;          /** 存储商品描述的数组*/
@property (copy, nonatomic)     returnHeight heightBlock;       /**高度Black*/

@end
