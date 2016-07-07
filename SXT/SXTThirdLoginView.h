//
//  SXTThirdLoginView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QQLoginMethod)();

@interface SXTThirdLoginView : UIView

@property (copy, nonatomic) QQLoginMethod QQLoginBlock;

@end
