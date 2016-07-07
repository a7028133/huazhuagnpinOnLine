//
//  SXTLoginView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginBlock)(NSDictionary *dict);
typedef void(^landingBlock)();

@interface SXTLoginView : UIView

/**登陆block*/
@property (copy, nonatomic) loginBlock loginBlock;
/**去注册block*/
@property (copy, nonatomic) landingBlock landingBlock;

@end





