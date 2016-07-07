//
//  SXTPayOrderView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^payMoneyBlock)();
@interface SXTPayOrderView : UIView

@property (strong, nonatomic)   NSAttributedString *payMoneyString;              /** 支付金额 */
@property (copy, nonatomic)     payMoneyBlock payBlock;/** 支付回调 */

@end
