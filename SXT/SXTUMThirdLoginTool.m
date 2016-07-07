//
//  SXTUMThirdLoginTool.m
//  SXT
//
//  Created by 赵金鹏 on 16/6/21.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTUMThirdLoginTool.h"
#import "UMSocial.h"
@implementation SXTUMThirdLoginTool


+ (void)qqLoginMethod:(UIViewController *)VC
              success:(loginSuccess)returnSuccess
           loginError:(loginError)returnError{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(VC,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
             NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            if (returnSuccess) {
                returnSuccess(dict);
            }else{
                if (returnError) {
                    returnError();
                }
            }
            
        }});
}

@end
