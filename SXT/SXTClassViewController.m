//
//  SXTClassViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTClassViewController.h"
#import "SXTClassCollectionView.h"
#import "SXTEffectClassModel.h"
#import "SXTClassCollectionModel.h"
#import "SXTClassListViewController.h"
@interface SXTClassViewController ()

@property (strong, nonatomic)   SXTClassCollectionView *classCollection;              /** 分类列表 */

@end

@implementation SXTClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.classCollection];
    __weak typeof (self) weakSelf = self;
    [_classCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self referData];
    // Do any additional setup after loading the view.
}

- (void)referData{
    
    //推荐品牌
    [self getDataFromSever:@"appBrandareanew/findBrandareanew.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        _classCollection.classicClassArray = [SXTClassCollectionModel mj_objectArrayWithKeyValuesArray:project];
        [_classCollection reloadData];
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    //经典品牌
    [self getDataFromSever:@"appBrandarea/asianBrand.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        _classCollection.recommendClassArray = [SXTClassCollectionModel mj_objectArrayWithKeyValuesArray:project];
        [_classCollection reloadData];
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    //功效
    [self getDataFromSever:@"appBrandareatype/findBrandareatype.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        _classCollection.effectArray = [SXTEffectClassModel mj_objectArrayWithKeyValuesArray:project];
        [_classCollection reloadData];
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (SXTClassCollectionView *)classCollection{
    if (!_classCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger itemWidth = (VIEW_WIDTH - 3) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 0);
        flowLayout.headerReferenceSize = CGSizeMake(0, 35);
        _classCollection = [[SXTClassCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _classCollection.backgroundColor = RGB(245, 245, 245);
        __weak typeof (self) weakSelf = self;
        _classCollection.selectCellBlock = ^ (NSDictionary *parameterDic){
            [weakSelf pushToClassListViewController:parameterDic];
        };

    }
    return _classCollection;
}

- (void)pushToClassListViewController:(NSDictionary *)parameterDic{
    SXTClassListViewController *classList = [[SXTClassListViewController alloc]init];
    classList.idDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:parameterDic[@"URL"],@"URL",parameterDic[@"ShopID"],@"ID",parameterDic[@"Type"],@"keyword", nil];
    classList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:classList animated:YES];
}

- (NSDictionary *)makeIdDictionary:(NSString *)shopID{
    
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
