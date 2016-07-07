//
//  SXTLandingNextView.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTLandingNextView : UIView

@property (strong, nonatomic)   UIButton *referButton;              /** 重新发送验证码按钮 */
@property (strong, nonatomic)   UILabel *timeLabel;                 /** 计时label */
@property (strong, nonatomic)   UIButton *landingButton;            /** 注册按钮 */
@property (strong, nonatomic)   UITextField *verificationText;      /** 验证码输入框 */

@end
