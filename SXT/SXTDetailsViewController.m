//
//  SXTDetailsViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTDetailsViewController.h"
#import "SXTDetailsAllLabelView.h"
#import "SXTDetailListModel.h"
#import "SXTDetailsHeadImageView.h"
#import "SXTDetailsTitleView.h"
#import "SXTFindGoodsDetailModel.h"
#import "SXTFindGoodsImgListModel.h"
#import "SXTDetailsAllImageView.h"
#import "SXTDetailsBuyCarView.h"
#import "UIImage+ColorMakeImage.h"
#import "SXTClassListViewController.h"
#import "SXTLoginViewController.h"

#import "UMSocial.h"


@interface SXTDetailsViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic)   UIScrollView *mainScroll;            /** 底部滚动视图 */
@property (strong, nonatomic)   UIView *scrollMainView;              /** scroll的view */
@property (strong, nonatomic)   SXTDetailsAllLabelView *allLabelView; /** 所有label的view */
@property (strong, nonatomic)   SXTDetailsTitleView *detailsTitleView; /** 描述文字 */
@property (strong, nonatomic)   SXTDetailsHeadImageView *detailHeadImageView; /** 头部滚动图片 */
@property (strong, nonatomic)   SXTDetailsAllImageView *detailAllImageView; /** 所有图片 */
@property (strong, nonatomic)   SXTDetailsBuyCarView *detailBuyCarView;              /** 加入购物车按钮 */
@property (assign, nonatomic)   CGFloat mainScrollContentHeight;    /**记录scroll高度*/
@property (strong, nonatomic)   UIButton *collectButton;              /** 收藏按钮 */
@property (strong, nonatomic)   UIButton *shareButton;              /** 分享按钮 */

@end

@implementation SXTDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
//    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    //给mainScrollContentHeight一个初始值
    self.mainScrollContentHeight = 230;
    //自适应Scroll内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.mainScroll];
    [_mainScroll addSubview:self.scrollMainView];
    [_scrollMainView addSubview:self.detailHeadImageView];
    [_scrollMainView addSubview:self.detailsTitleView];
    [_scrollMainView addSubview:self.allLabelView];
    [_scrollMainView addSubview:self.detailAllImageView];
    [self.view addSubview:self.detailBuyCarView];
    
    //给控件添加约束
    [self addLyaoutInView];
    //请求数据
    [self reloadData];
    //设置nav
    [self settingNavgation];
    // Do any additional setup after loading the view.
}

- (void)settingNavgation{
    //控制nav的透明度
    UIColor * whiteColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    UIImage * whiteImage = [UIImage imageWithColor:whiteColor];
    //给navigationBar设背景
    [self.navigationController.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
    //设置navigationBar阴影
    [self.navigationController.navigationBar setShadowImage:whiteImage];
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:self.collectButton];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareButton];
    NSArray *barItemArray = @[collectItem,shareItem];
    self.navigationItem.rightBarButtonItems = barItemArray;
    
    
}

- (void)addLyaoutInView{
    WS(weakSelf);
    [_mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    [_detailsTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollMainView.mas_top).offset(230);
        make.left.equalTo(weakSelf.scrollMainView.mas_left);
        make.right.equalTo(weakSelf.scrollMainView.mas_right);
        make.height.equalTo(1);
    }];
    [_allLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailsTitleView.mas_bottom);
        make.left.equalTo(weakSelf.scrollMainView.mas_left);
        make.right.equalTo(weakSelf.scrollMainView.mas_right);
        make.height.equalTo(1);
    }];
    [_detailAllImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.allLabelView.mas_bottom);
        make.left.equalTo(weakSelf.scrollMainView.mas_left);
        make.right.equalTo(weakSelf.scrollMainView.mas_right);
        make.height.equalTo(1);
    }];
}

- (void)reloadData{
    WS(weakSelf);
    //商品描述
    [self getDataFromSever:@"appGoods/findGoodsDetailList.do"
                 parameter:@{@"GoodsId":_goodsID}
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     
                     weakSelf.allLabelView.detailListModel = [SXTDetailListModel mj_objectArrayWithKeyValuesArray:project];
                     
                 } isError:^(NSURLSessionDataTask *task, NSError *error) {
                     
                 }];
    //商品图片列表
    [self getDataFromSever:@"appGoods/findGoodsImgList.do"
                 parameter:@{@"GoodsId":_goodsID}
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     NSArray *imageArray = [SXTFindGoodsImgListModel mj_objectArrayWithKeyValuesArray:project];
                     NSMutableArray *headImage = [NSMutableArray arrayWithCapacity:0];
                     for (SXTFindGoodsImgListModel *image in imageArray) {
                         if ([image.ImgType isEqual:@"1"]) {
                             [headImage addObject:image.ImgView];
                         }
                     }
                     weakSelf.detailHeadImageView.headImage.imageURLStringsGroup = headImage;
                     weakSelf.detailAllImageView.imageArray = imageArray;
                     
                 } isError:^(NSURLSessionDataTask *task, NSError *error) {
                     
                 }];
    //商品信息
    [self getDataFromSever:@"appGoods/findGoodsDetail.do"
                 parameter:@{@"GoodsId":_goodsID}
                 isSuccess:^(NSURLSessionDataTask *task, id project) {
                     
                     weakSelf.detailsTitleView.informationModel = [SXTFindGoodsDetailModel mj_objectWithKeyValues:project];
                     weakSelf.detailHeadImageView.haveBug = weakSelf.detailsTitleView.informationModel.BuyCount;
                 } isError:^(NSURLSessionDataTask *task, NSError *error) {
                     
                 }];
}

- (UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _collectButton.frame = CGRectMake(0, 0, 30, 30);
        [_collectButton setImage:[UIImage imageNamed:@"详情界面收藏按钮"] forState:(UIControlStateNormal)];
        [_collectButton setImage:[UIImage imageNamed:@"详情界面收藏按钮sel"] forState:(UIControlStateSelected)];
        [_collectButton addTarget:self action:@selector(pushToLoginView) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _collectButton;
}

- (UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shareButton.frame = CGRectMake(0, 0, 30, 30);
        [_shareButton setImage:[UIImage imageNamed:@"详情界面转发按钮"] forState:(UIControlStateNormal)];
        [_shareButton addTarget:self action:@selector(shareMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shareButton;
}

- (void)shareMethod{

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"你个傻逼"
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:nil];
}

- (SXTDetailsAllLabelView *)allLabelView{
    if (!_allLabelView) {
        _allLabelView = [[SXTDetailsAllLabelView alloc]init];
        WS(weakSelf);
        _allLabelView.labelHeightBlock = ^(CGFloat height){
            [weakSelf.allLabelView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(height);
            }];
            weakSelf.mainScrollContentHeight += height;
        };
    }
    return _allLabelView;
}

- (SXTDetailsTitleView *)detailsTitleView{
    if (!_detailsTitleView) {
        _detailsTitleView = [[SXTDetailsTitleView alloc]init];
        _detailsTitleView.backgroundColor = [UIColor whiteColor];
        WS(weakSelf);
        _detailsTitleView.heightBlock = ^(CGFloat height){
            [weakSelf.detailsTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(height);
            }];
            weakSelf.mainScrollContentHeight += height;
        };
        [_detailsTitleView.whiteButton addTarget:self action:@selector(pushToClassListViewControllerMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _detailsTitleView;
}

- (SXTDetailsAllImageView *)detailAllImageView{
    if (!_detailAllImageView) {
        _detailAllImageView = [[SXTDetailsAllImageView alloc]init];
        WS(weakSelf);
        _detailAllImageView.imageBlock = ^(CGFloat height){
            [weakSelf.detailAllImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(height);
            }];
            weakSelf.mainScrollContentHeight += height;
        };
    }
    return _detailAllImageView;
}

- (SXTDetailsHeadImageView *)detailHeadImageView{
    if (!_detailHeadImageView) {
        _detailHeadImageView = [[SXTDetailsHeadImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230)];
    }
    return _detailHeadImageView;
}

- (SXTDetailsBuyCarView *)detailBuyCarView{
    if (!_detailBuyCarView) {
        _detailBuyCarView = [[SXTDetailsBuyCarView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-45, VIEW_WIDTH, 45)];
        [_detailBuyCarView.addInBuyCarButton addTarget:self action:@selector(addGoodsForBuyCar) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _detailBuyCarView;
}
- (UIScrollView *)mainScroll{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _mainScroll.delegate = self;
        _mainScroll.userInteractionEnabled = YES;
        _mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
        _mainScroll.contentSize = CGSizeMake(0, 230);
    }
    return _mainScroll;
}
- (UIView *)scrollMainView{
    if (!_scrollMainView) {
        _scrollMainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    }
    return _scrollMainView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 170) {
        //实现上面headImage滚动比其他内容慢一点的操作
        CGRect rect = _detailHeadImageView.frame;
        rect.origin.y = scrollView.contentOffset.y/2;
        _detailHeadImageView.frame = rect;
        
        //通过类别将颜色转换为图片
        UIColor * whiteColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:scrollView.contentOffset.y/170];
        UIImage * whiteImage = [UIImage imageWithColor:whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (void)setMainScrollContentHeight:(CGFloat)mainScrollContentHeight{
    _mainScrollContentHeight = mainScrollContentHeight;
    _mainScroll.contentSize = CGSizeMake(0, _mainScrollContentHeight);
}

- (void)pushToClassListViewControllerMethod{
    SXTClassListViewController *classList = [[SXTClassListViewController alloc]init];
//    classList.shopID = _detailsTitleView.informationModel.ShopId;
    classList.idDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"appShop/appShopGoodsList.do",@"URL",
                              _detailsTitleView.informationModel.ShopId,@"ID",
                              @"ShopId",@"keyword", nil];
    [self.navigationController pushViewController:classList animated:YES];
}

- (void)pushToLoginView{
    
    NSDictionary *memberID = [[NSUserDefaults standardUserDefaults] valueForKey:@"ISLOGIN"];
    NSDictionary *dic = @{@"GoodsId":self.detailsTitleView.informationModel.GoodsId,@"CollectionType":@"1",@"MemberId":memberID[@"MemberId"],@"RelatedType":@"1"};
    
    [self getDataFromSever:@"appCollection/insertIOS.do" parameter:dic isSuccess:^(NSURLSessionDataTask *task, id project) {
        NSLog(@"---------project : %@",project);
    } isError:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---------error : %@",error);
    }];
    
}

- (void)addGoodsForBuyCar{
    NSDictionary *memberDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"ISLOGIN"];
    if ([memberDic isKindOfClass:[NSNull class]]) {
        [self showTostView:@"请登录"];
    }else{
        [self getDataFromSever:@"appShopCart/insert.do" parameter:@{@"MemberId":memberDic[@"MemberId"],@"GoodsId":_detailsTitleView.informationModel.GoodsId} isSuccess:^(NSURLSessionDataTask *task, id project) {
            NSLog(@"%@",project);
        } isError:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



@end











