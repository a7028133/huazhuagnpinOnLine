//
//  SXTSureOrderViewController.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTBaseViewController.h"

@interface SXTSureOrderViewController : SXTBaseViewController

@property (strong, nonatomic)   NSArray *orderDataArray;              /** 确认订单 */

/**价格*/
@property (copy, nonatomic) NSString *payMoneyStr;
@end
