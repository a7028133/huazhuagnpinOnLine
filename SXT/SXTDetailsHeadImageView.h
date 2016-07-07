//
//  SXTDetailsHeadImageView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface SXTDetailsHeadImageView : UIView

@property (strong, nonatomic)   SDCycleScrollView *headImage;              /** 头部图片 */
@property (strong, nonatomic)   NSString *haveBug;              /** 已经购买的人数 */
@end
