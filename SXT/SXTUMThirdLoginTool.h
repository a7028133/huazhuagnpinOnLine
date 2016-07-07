//
//  SXTUMThirdLoginTool.h
//  SXT
//
//  Created by 赵金鹏 on 16/6/21.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loginSuccess)(NSDictionary *);
typedef void(^loginError)();

@interface SXTUMThirdLoginTool : NSObject

//@property (copy, nonatomic) successBlock LoginSuccessBlock;
//@property (copy, nonatomic) errorBlock LoginErrorBlock;

+ (void)qqLoginMethod:(UIViewController *)VC
              success:(loginSuccess)returnSuccess
           loginError:(loginError)returnError;

@end
