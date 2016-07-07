//
//  SXTBuyCarTableView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dataArrayBlock)(NSMutableArray *array);

@interface SXTBuyCarTableView : UITableView

@property (strong, nonatomic)   NSMutableArray *dataArray;              /** 存储数据的数组 */
@property (copy, nonatomic)     dataArrayBlock dataArrayblock;          /** 返回数据的block*/
@end
