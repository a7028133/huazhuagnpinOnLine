//
//  SXTClassListViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/12.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTClassListViewController.h"
#import "SCTClassListFourButtonView.h"
#import "SXTClassListCollectionView.h"
#import "SXTClassListCollectionCell.h"
#import "SXTClassListViewModel.h"
#import "SXTDetailsViewController.h"
@interface SXTClassListViewController()

@property (strong, nonatomic)   SCTClassListFourButtonView *fourButtonView;              /** 四个选项View */
@property (strong, nonatomic)   SXTClassListCollectionView *classCollectionView;              /** collectionView */
@end



@implementation SXTClassListViewController

- (NSMutableDictionary *)idDictionary{
    if (!_idDictionary) {
        _idDictionary = [NSMutableDictionary dictionary];
    }
    return _idDictionary;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.fourButtonView];
    [self.view addSubview:self.classCollectionView];
    self.edgesForExtendedLayout = 0;
    [self addLayoutWithControl];
    //请求数据
    [self reloadData:@{@"OrderName":@"host",@"OrderType":@"DESC",_idDictionary[@"keyword"]:_idDictionary[@"ID"]}];
}

- (void)addLayoutWithControl{
    __weak typeof (self) weakSelf = self;
    [_fourButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.view);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 30));
    }];
    [_classCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.fourButtonView.mas_bottom);
    }];
}
- (SCTClassListFourButtonView *)fourButtonView{
    if (!_fourButtonView) {
        _fourButtonView = [[SCTClassListFourButtonView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        _fourButtonView.shopID = _shopID;
        WS(weakSelf);
        _fourButtonView.parameterDictionary = ^(NSDictionary *parameterDic){
            [weakSelf reloadData:parameterDic];
        };
    }
    return _fourButtonView;
}

- (SXTClassListCollectionView *)classCollectionView{
    if (!_classCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger itemWidth = (VIEW_WIDTH - 10) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.618);
        _classCollectionView = [[SXTClassListCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)collectionViewLayout:flowLayout];
        _classCollectionView.backgroundColor = RGB(248, 248, 248);
        __weak typeof (self) weakSelf = self;
        _classCollectionView.selectCoods = ^ (NSString *goodsID){
            [weakSelf pushToDetailsViewController:goodsID];
        };
        
    }
    return _classCollectionView;
}

- (void)pushToDetailsViewController:(NSString *)goodsID{
    SXTDetailsViewController *detailsViewController = [[SXTDetailsViewController alloc]init];
    detailsViewController.goodsID = goodsID;
    detailsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

- (void)reloadData:(NSDictionary *)parameter{
    if ([_idDictionary[@"keyword"] isEqualToString:@"search"]) {
        [self postDataFromSever:_idDictionary[@"URL"]
                     parameter:[self makeParameterDic:parameter]
                     isSuccess:^(NSURLSessionDataTask *task, id project) {
                         
                         _classCollectionView.classListArray = [SXTClassListViewModel mj_objectArrayWithKeyValuesArray:project];
                         
                         if (_classCollectionView.classListArray.count == 0) {
                             [self showTostView:@"没有搜索到商品"];
                         }else
                             [_classCollectionView reloadData];
                     } isError:^(NSURLSessionDataTask *task, NSError *error) {
                         
                     }];
    }else{
        [self getDataFromSever:_idDictionary[@"URL"]
                     parameter:[self makeParameterDic:parameter]
                     isSuccess:^(NSURLSessionDataTask *task, id project) {
                         
                         _classCollectionView.classListArray = [SXTClassListViewModel mj_objectArrayWithKeyValuesArray:project];
                         [_classCollectionView reloadData];
                     } isError:^(NSURLSessionDataTask *task, NSError *error) {
                         
                     }];
    }
    
}
- (NSDictionary *)makeParameterDic:(NSDictionary *)dict{
    //@"OrderName":@"host",@"OrderType":@"DESC",@"ShopId":self.shopID
    NSDictionary *parameter = @{@"OrderName":dict[@"OrderName"],@"OrderType":dict[@"OrderType"],_idDictionary[@"keyword"]:_idDictionary[@"ID"]};
    return parameter;
}

@end





















