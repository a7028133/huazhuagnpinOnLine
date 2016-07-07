//
//  SXTTimerViewModel.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/4.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTTimerViewModel : NSObject
/**关联ID（活动ID）*/
@property (copy, nonatomic) NSString *RelatedId;

/**图片地址*/
@property (copy, nonatomic) NSString *ImgView;

/**活动描述*/
@property (copy, nonatomic) NSString *CommodityText;
@end
