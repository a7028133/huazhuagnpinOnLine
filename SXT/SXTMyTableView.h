//
//  SXTMyTableView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^exitBlock)();
@interface SXTMyTableView : UITableView

@property (copy, nonatomic)   exitBlock exitBlock;              /** 退出回调 */
@property (strong, nonatomic)   NSArray *dataArray;              /** 显示数组 */

@end
