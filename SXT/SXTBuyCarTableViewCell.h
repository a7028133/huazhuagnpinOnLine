//
//  SXTBuyCarTableViewCell.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTBuyCarModel.h"
@interface SXTBuyCarTableViewCell : UITableViewCell

@property (strong, nonatomic)   SXTBuyCarModel *BuyCarModel;              /** 购物车model */
@property (strong, nonatomic)   UILabel *countLabel;              /** 数量 */
@property (strong, nonatomic)   UIButton *selectButton;              /** 是否选中按钮 */
@property (strong, nonatomic)   UIButton *addButton;              /** 增加数量 */
@property (strong, nonatomic)   UIButton *cutButton;              /** 减少数量 */

@end
