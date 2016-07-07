//
//  NSString+Helper.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "NSMutableAttributedString+Helper.h"

@implementation NSMutableAttributedString (Helper)
/**制作一个带删除线的字符串*/
+ (NSMutableAttributedString *)makeStrikethroughAttributedString:(NSString *)frontString :(NSString *)backString rebateString:(NSString *)rebateStr{
    NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor redColor],
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:22]};
    NSString *front = [frontString stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    NSString* temp = [NSString stringWithFormat:@"￥%@ ",front];
    NSAttributedString * string1 = [[NSAttributedString alloc] initWithString:temp attributes:dict];
    
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:[UIColor grayColor],
                             NSFontAttributeName:[UIFont systemFontOfSize:12],
                             NSStrikethroughStyleAttributeName:@(2)};
    NSAttributedString * string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ",backString] attributes:dict2];
    
    
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] init];
    [string insertAttributedString:string1 atIndex:0];
    [string insertAttributedString:string2 atIndex:string1.length];
    
    if (rebateStr.length != 0) {
        NSDictionary *dict3 = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:12]};
        NSAttributedString *string3 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"(%@折)",backString] attributes:dict3];
        [string insertAttributedString:string3 atIndex:string.length];
    }
    
    
    return string;
}


+ (NSMutableAttributedString *)makeOrderPriceText:(NSString *)priceStr{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    NSDictionary *attributedDic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0],
                                    NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *attributed1 = [[NSAttributedString alloc]initWithString:@"合计 : " attributes:attributedDic1];
    
    NSDictionary *attributedDic2 = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0],
                                     NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *attributed2 = [[NSAttributedString alloc]initWithString:priceStr attributes:attributedDic2];
    [attributedString insertAttributedString:attributed1 atIndex:0];
    [attributedString insertAttributedString:attributed2 atIndex:attributed1.length];
    return attributedString;
}

@end
