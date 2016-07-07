//
//  SXTSureOrderViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTSureOrderViewController.h"
#import "SXTOrderTableView.h"
#import "SXTPayOrderView.h"
#import "NSMutableAttributedString+Helper.h"

#import "SXTBuyCarModel.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@interface SXTSureOrderViewController ()
@property (strong, nonatomic)   SXTOrderTableView *orderTable;              /** 订单列表 */
@property (strong, nonatomic)   SXTPayOrderView *payOrderView;              /** 支付view */
@end

@implementation SXTSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.orderTable];
    [self.view addSubview:self.payOrderView];
    
    WS(weakSelf);
    [_orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    [_payOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.right.and.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.orderTable.mas_bottom);
    }];
    // Do any additional setup after loading the view.
}

- (SXTOrderTableView *)orderTable{
    if (!_orderTable) {
        _orderTable = [[SXTOrderTableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-50) style:(UITableViewStylePlain)];
        _orderTable.orderDataArray = _orderDataArray;
        [_orderTable reloadData];
    }
    return _orderTable;
}

- (SXTPayOrderView *)payOrderView{
    if (!_payOrderView) {
        _payOrderView = [[SXTPayOrderView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-50, VIEW_WIDTH, 50)];
        _payOrderView.payMoneyString = [NSMutableAttributedString makeOrderPriceText:_payMoneyStr];
        WS(weakSelf);
        _payOrderView.payBlock = ^{
            [weakSelf PayMoneyMethod];
        };
    }
    return _payOrderView;
}

- (void)PayMoneyMethod{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088811244629885";
    NSString *seller = @"2088811244629885";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMtWTF/ZNrWvKTVBnKQnamD1GgTvGjm7gLxgWe9pGos/rLYZXQnAuNkQRPgnITwtCOclWMYHvTyufYWoCQgl6mYmL4UEccFwk7ehf8c+pJ3Tm0XTS6//ohcR/B8qD+jiQOxpU33A+UoplCRohlZv5Z2S+0xt/I5QLi0Nb8J0xY3AgMBAAECgYBONJmMr9MlrO2hzonq1e+WwPAXU/Emx4GPRF3px59du/HCj9r3E7qgisdYw6Nz0U8dBd0F++BLngbNiHtafoTGCO6bKJY6Wdiv7zbhC1YuOKAvFbPRKj6pDShZ0lGbIubE6fBtZ5u6nSwh6tr28Y7TLkfX04cYlHFq7u779EBIgQJBAOGg/rRROUwrpf9bMV8z7KMOFlE7EXtg/o0tinJYBd+lvtfAkdpgzQ5JOxfywmfcI33U+RXyFoMLSTuBtfDTb6cCQQDdcwJB/FfBb5HTrOMqshUXsEukT+SWs2vS6TKAlvyd2XGwJ/fP9mdyxtinTNJRpGM0uI+gF6EHfj6blbViMHbxAkA4Pbk/mT9/DSJDlKep43eI7WoCtYaWCodpCYEJH4fXR6laflXc6WQzu21PeuOan/T42K1+GuohoB6RBrQjY5DhAkEAwppmyYXvuFVLWTD9EHAeiQqr7mEnCCf0AQxdDROiOzTy61K0O1TV489KZPrleEl1xMbLsGwTXnpamm8dToQ4gQJBANjWYtsLAxbxgNF9zAKj+B38r0AInsxbY6TV77iejVGhL9wbnJtN5QHQ6yXTlvS6Cb5hmPDcbsM0rSrCyXpD38o=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"尚学堂"; //商品标题
    order.productDescription = @""; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",[_payMoneyStr floatValue]]; //商品价格
    order.amount = [NSString stringWithFormat:@"0.01"]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"SXT";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
