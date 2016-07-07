//
//  SXTTimeViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/28.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTTimeViewController.h"
#import "SXTTimeHomeTableview.h"
#import "SXTTwoButtonView.h"
#import "SXTTimerViewModel.h"
#import "SXTTimerSingleModel.h"
#import "SXTTimerGroupBuyModel.h"
#import "SXTDetailsViewController.h"
#import "SXTClassListViewController.h"
#import "SXTSearchViewController.h"
#import "SDCycleScrollView.h"


@interface SXTTimeViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (strong, nonatomic)   UIScrollView *mainScroll;
@property (strong, nonatomic)   SXTTimeHomeTableview *singleTableView;
@property (strong, nonatomic)   SXTTimeHomeTableview *groupBuyTableView;
@property (strong, nonatomic)   SDCycleScrollView *headImageView;
@property (strong, nonatomic)   SXTTwoButtonView *twoButtonView;
@property (strong, nonatomic)   NSArray *headImageArray;
@property (strong, nonatomic)   UIBarButtonItem *searchButItem;
@end

@implementation SXTTimeViewController

- (void)viewDidDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;600-400
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = self.searchButItem;
    [self.view addSubview:self.mainScroll];
    WS(weakSelf);
    [_mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_mainScroll addSubview:self.headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mainScroll.mas_left);
        make.top.equalTo(weakSelf.mainScroll.mas_top);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 230));
    }];
    
    [_mainScroll addSubview:self.singleTableView];
    [_mainScroll addSubview:self.groupBuyTableView];
    [_mainScroll addSubview:self.twoButtonView];
    
    [self referHeadImageView];
    // Do any additional setup after loading the view.
}
- (void)referHeadImageView{
    WS(weakSelf);
    
    //请求轮播图片
    [self getDataFromSever:@"appHome/appHome.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        NSArray *model = [SXTTimerViewModel mj_objectArrayWithKeyValuesArray:project];
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:model.count];
        for (SXTTimerViewModel *user in model) {
            [imageArray addObject:user.ImgView];
        }
        weakSelf.headImageView.imageURLStringsGroup = [NSArray arrayWithArray:imageArray];
        
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"--------error : %@",error);
    }];
    
    //请求单品团购
    [self getDataFromSever:@"appActivity/appHomeGoodsList.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        NSArray *model = [SXTTimerSingleModel mj_objectArrayWithKeyValuesArray:project];
        weakSelf.singleTableView.singleListArray = model;
        //修改scrol的滑动范围
        weakSelf.mainScroll.contentSize = CGSizeMake(0, model.count*170+280);
        //改变table的大小，使table不能进行滚动
        CGRect singleRect = _singleTableView.frame;
        singleRect.size.height = model.count * 170;
        _singleTableView.frame = singleRect;
        [weakSelf.singleTableView reloadData];
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"--------error : %@",error);
    }];
    
    //请求品牌团购
    [self getDataFromSever:@"appActivity/appActivityList.do" parameter:nil isSuccess:^(NSURLSessionDataTask *task, id project) {
        NSArray *model = [SXTTimerGroupBuyModel mj_objectArrayWithKeyValuesArray:project];
        weakSelf.groupBuyTableView.groupBuyListArray = model;
        CGRect groupRect = _groupBuyTableView.frame;
        groupRect.size.height = model.count * 175;
        _groupBuyTableView.frame = groupRect;
        [weakSelf.groupBuyTableView reloadData];
        
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"--------error : %@",error);
    }];
}
//单品团购table
- (SXTTimeHomeTableview *)singleTableView{
    if (!_singleTableView) {
        _singleTableView = [[SXTTimeHomeTableview alloc]initWithFrame:CGRectMake(0, 280, VIEW_WIDTH, 0) style:(UITableViewStylePlain)];
        _singleTableView.isSingle = YES;
        WS(weakSelf);
        _singleTableView.singleBlock = ^(NSString *goodsID){
            SXTDetailsViewController *detailsViewControll = [[SXTDetailsViewController alloc]init];
            detailsViewControll.goodsID = goodsID;
            detailsViewControll.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:detailsViewControll animated:YES];
//            weakSelf.tabBarController.tabBar.hidden = YES;
        };
    }
    return _singleTableView;
}
//品牌团购table
- (SXTTimeHomeTableview *)groupBuyTableView{
    if (!_groupBuyTableView) {
        _groupBuyTableView = [[SXTTimeHomeTableview alloc]initWithFrame:CGRectMake(VIEW_WIDTH, 280, VIEW_WIDTH, 0) style:(UITableViewStylePlain)];
        _groupBuyTableView.isSingle = NO;
        WS(weakSelf);
        _groupBuyTableView.groupBlock = ^(NSString *groupId){
            SXTClassListViewController *classList = [[SXTClassListViewController alloc]init];
            classList.idDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"appGgroupon/appGrounpGoodsList.do",@"URL",groupId,@"ID",@"GrouponId",@"keyword", nil];
            classList.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:classList animated:YES];
        };
    }
    return _groupBuyTableView;
}
- (SDCycleScrollView *)headImageView{
    if (!_headImageView) {
        _headImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230) delegate:self placeholderImage:[UIImage imageNamed:@"桌面"]];
        _headImageView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headImageView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _headImageView;
}
- (UIScrollView *)mainScroll{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.delegate = self;
        _mainScroll.backgroundColor = [UIColor whiteColor];
    }
    return _mainScroll;
}
//切换单品与团购显示table的view
- (SXTTwoButtonView *)twoButtonView{
    if (!_twoButtonView) {
        _twoButtonView = [[SXTTwoButtonView alloc]initWithFrame:CGRectMake(0, 230, VIEW_WIDTH, 50)];
        [_twoButtonView.singleButton addTarget:self action:@selector(twoButtonMethod:) forControlEvents:(UIControlEventTouchUpInside)];
        [_twoButtonView.groupBuyButton addTarget:self action:@selector(twoButtonMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _twoButtonView;
}
- (UIBarButtonItem *)searchButItem{
    if (!_searchButItem) {
        UIButton *search = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [search setImage:[UIImage imageNamed:@"限时特卖界面搜索按钮"] forState:(UIControlStateNormal)];
        search.frame = CGRectMake(0, 0, 30, 30);
        [search addTarget:self action:@selector(pushSearchViewController) forControlEvents:(UIControlEventTouchUpInside)];
        _searchButItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    }
    return _searchButItem;
}

- (void)pushSearchViewController{
    
    SXTSearchViewController *search = [[SXTSearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];

}
- (void)twoButtonMethod:(UIButton *)sender{
    if (sender == _twoButtonView.singleButton) {
        _twoButtonView.singleButton.selected = YES;
        _twoButtonView.groupBuyButton.selected = NO;
        _mainScroll.contentSize = CGSizeMake(0, _singleTableView.singleListArray.count*170+280);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect singleRect = _singleTableView.frame;
            singleRect.origin.x = 0;
            _singleTableView.frame = singleRect;
            
            CGRect groupRect = _groupBuyTableView.frame;
            groupRect.origin.x = VIEW_WIDTH;
            _groupBuyTableView.frame = groupRect;
        }];
    }else{
        _twoButtonView.singleButton.selected = NO;
        _twoButtonView.groupBuyButton.selected = YES;
        _mainScroll.contentSize = CGSizeMake(0, _groupBuyTableView.groupBuyListArray.count*175+280);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect singleRect = _singleTableView.frame;
            singleRect.origin.x = -VIEW_WIDTH;
            _singleTableView.frame = singleRect;
            
            CGRect groupRect = _groupBuyTableView.frame;
            groupRect.origin.x = 0;
            _groupBuyTableView.frame = groupRect;
        }];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_mainScroll]) {
        if (scrollView.contentOffset.y > 230) {
//            scrollView.contentSize
            CGRect twoBtnRect = _twoButtonView.frame;
            twoBtnRect.origin.y = scrollView.contentOffset.y;
            _twoButtonView.frame = twoBtnRect;
        }else{
            _twoButtonView.frame = CGRectMake(0, 230, VIEW_WIDTH, 50);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end








