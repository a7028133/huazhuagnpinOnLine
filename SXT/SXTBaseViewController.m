//
//  SXTBaseViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/31.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTBaseViewController.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"

//appMember/createSeekPwdCode.do?Telephone=17721025595
static NSString * const BaseURLString = @"http://123.57.141.249:8080/beautalk/";//
//static NSString * const BaseURLString = @"http://192.57.141.249:8080/beautalk/";

@implementation AFNetworkingClient

+ (instancetype)sharedClient{
    
    static AFNetworkingClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[AFNetworkingClient alloc]initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    });
    
    return sharedClient;
}


@end



@interface SXTBaseViewController ()

@end

@implementation SXTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postDataFromSever:(NSString *)URL
                parameter:(NSDictionary *)parameter
                isSuccess:(successBlock)success
                  isError:(errorBlock)isError{
    WS(weakSelf);
    [SVProgressHUD show];
    [[AFNetworkingClient sharedClient] POST:URL
                                parameters:parameter
                                  progress:nil
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       [SVProgressHUD dismiss];
                                       if (success) {
                                           success(task,responseObject);
                                       }
                            
                                       
                                   }
                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      [SVProgressHUD dismiss];
                                       [weakSelf showTostView:@"请检查网络连接状态"];
                                       if (isError) {
                                           isError(task,error);
                                       }
                                      
                                   }];
    
}


- (void)getDataFromSever:(NSString *)URL
               parameter:(NSDictionary *)parameter
               isSuccess:(successBlock)success
                 isError:(errorBlock)errorblock{
    WS(weakSelf);
    [SVProgressHUD show];
    [[AFNetworkingClient sharedClient]GET:URL
                               parameters:parameter
                                 progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             [SVProgressHUD dismiss];
                                        if (success) {
                                                 success(task,responseObject);
                                             }
                                             
                                         }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             [SVProgressHUD dismiss];
                                         [weakSelf showTostView:@"请检查网络连接状态"];
                                         if (errorblock) {
                                             errorblock(task,error);
                                         }
                                             
                                }];
    
}

- (void)addBackButtonOnNav{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"详情界面返回按钮"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(returnViewController) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)returnViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showTostView:(NSString *)tostString{
    [self.view makeToast:tostString duration:1.3 position:@"center"];
}

- (void)dealloc{
    [[AFNetworkingClient sharedClient].operationQueue cancelAllOperations];
}


@end
