//
//  NSString+Helper.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/** 一串字符在固定宽度下，正常显示所需要的高度 method*/

+ (CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(UIFont *)font;

@end
