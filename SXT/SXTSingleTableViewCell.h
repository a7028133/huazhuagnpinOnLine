//
//  SXTSingleTableViewCell.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/2.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTTimerSingleModel.h"

@interface SXTSingleTableViewCell : UITableViewCell

@property (strong, nonatomic)   SXTTimerSingleModel *singleList;              /** 存储数据的模型 */

@end
