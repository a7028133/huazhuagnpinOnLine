//
//  SCTClassListFourButtonView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/12.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^parameterDictionaryBlock)(NSDictionary *dic);

@interface SCTClassListFourButtonView : UIView

@property (strong, nonatomic)   UIButton *hotButton;              /** 热门按钮 */
@property (strong, nonatomic)   UIButton *priceButton;              /** 价格按钮 */
@property (strong, nonatomic)   UIButton *goodButton;              /** 好评按钮 */
@property (strong, nonatomic)   UIButton *newsButton;              /** 新品按钮 */
@property (copy, nonatomic)     parameterDictionaryBlock parameterDictionary;
@end
