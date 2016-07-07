//
//  SXTBuyCarViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTBuyCarViewController.h"
#import "SXTBuyCarTableView.h"
#import "SXTBuyCarModel.h"
#import "SXTBuyCarTotalPriceView.h"
#import "SXTSureOrderViewController.h"

@interface SXTBuyCarViewController ()
@property (strong, nonatomic)   SXTBuyCarTableView *buyCarTableView;              /** 购物车列表 */
@property (strong, nonatomic)   NSMutableArray *buyCarData;              /** 存储购物车数据的数组 */
@property (strong, nonatomic)   SXTBuyCarTotalPriceView *priceView;              /** 显示价格View */
@end

@implementation SXTBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载购物车的tableview
    [self.view addSubview:self.buyCarTableView];
    //加载下面价格View
    [self.view addSubview:self.priceView];
    WS(weakSelf);
    [_buyCarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-44);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.equalTo(55);
        make.right.equalTo(weakSelf.view.mas_right);
    }];
    [self getBuyCarData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self getBuyCarData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    __block NSString *GoodsString = nil;
    __block NSMutableArray *GoodsArray = [NSMutableArray array];
    [_buyCarData enumerateObjectsUsingBlock:^(SXTBuyCarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodsString = [NSString stringWithFormat:@"%@,%li",obj.UUID,obj.GoodsCount];
        [GoodsArray addObject:GoodsString];
    }];

    GoodsString = [GoodsArray componentsJoinedByString:@"#"];
    [self postDataFromSever:@"appShopCart/appUpdateCart.do" parameter:@{@"updateCartMsg":GoodsString} isSuccess:^(NSURLSessionDataTask *task, id project) {
        NSLog(@"project : %@",project);
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getBuyCarData{
    NSDictionary *memberDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"ISLOGIN"];
    if (memberDic.count == 0) {
        [self showTostView:@"请登录"];
        self.priceView.hidden = YES;
    }else{
        self.priceView.hidden = NO;
        [self getDataFromSever:@"appShopCart/appCartGoodsList.do"
                     parameter:@{@"MemberId":memberDic[@"MemberId"]}
                     isSuccess:^(NSURLSessionDataTask *task, id project) {
            
                         _buyCarData = [SXTBuyCarModel mj_objectArrayWithKeyValuesArray:project];
                         
                         [_buyCarData enumerateObjectsUsingBlock:^(SXTBuyCarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                             [obj setIsSelectButton:YES];
                         }];
                         _buyCarTableView.dataArray = _buyCarData;
                         [_buyCarTableView reloadData];
                         [self countTotalPrice];
        } isError:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

- (SXTBuyCarTableView *)buyCarTableView{
    if (!_buyCarTableView) {
        _buyCarTableView = [[SXTBuyCarTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        WS(weakSelf);
        _buyCarTableView.dataArrayblock = ^(NSMutableArray *mutableArray){
            weakSelf.buyCarData = mutableArray;
            //重新计算价格
            [weakSelf countTotalPrice];
        };
    }
    return _buyCarTableView;
}

- (SXTBuyCarTotalPriceView *)priceView{
    if (!_priceView) {
        _priceView = [[SXTBuyCarTotalPriceView alloc]init];
        [_priceView.closingCostBtn addTarget:self action:@selector(pushToSureOrderViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _priceView;
}

- (void)countTotalPrice{
    __block CGFloat totalPrice = 0.0;
    __block NSInteger goodsCount = 0;
    [_buyCarData enumerateObjectsUsingBlock:^(SXTBuyCarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelectButton) {
            totalPrice += obj.Price * obj.GoodsCount;
        }
        goodsCount += obj.GoodsCount;
    }];
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",goodsCount];
    self.priceView.priceLabel.text = [NSString stringWithFormat:@"¥%.2lf",totalPrice];
}

- (void)pushToSureOrderViewController{
    SXTSureOrderViewController *sureOrder = [[SXTSureOrderViewController alloc]init];
    sureOrder.title = @"确认订单";
    sureOrder.hidesBottomBarWhenPushed = YES;
    sureOrder.orderDataArray = [self makeOrderDataArray];
    sureOrder.payMoneyStr = _priceView.priceLabel.text;
    [self.navigationController pushViewController:sureOrder animated:YES];
}

- (NSArray *)makeOrderDataArray{
    NSMutableArray *dataArray = [NSMutableArray array];
    [_buyCarData enumerateObjectsUsingBlock:^(SXTBuyCarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelectButton) {
            [dataArray addObject:obj];
        }
    }];
    return dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end









