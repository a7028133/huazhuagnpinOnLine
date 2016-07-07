//
//  SXTSearchViewController.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/13.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTSearchViewController.h"
#import "SXTClassListViewController.h"
@interface SXTSearchViewController ()<UISearchBarDelegate>

@property (strong, nonatomic)   UISearchBar *goodsSearchBar;

@end

@implementation SXTSearchViewController

- (UISearchBar *)goodsSearchBar{
    if (!_goodsSearchBar) {
        _goodsSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 40)];
        [_goodsSearchBar becomeFirstResponder];
        _goodsSearchBar.placeholder = @"输入要搜索的商品";
        _goodsSearchBar.showsCancelButton = YES;
        _goodsSearchBar.returnKeyType = UIReturnKeySearch;
        _goodsSearchBar.delegate = self;
    }
    return _goodsSearchBar;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    self.navigationItem.hidesBackButton = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.goodsSearchBar resignFirstResponder];
}

#pragma mark - searchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.goodsSearchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    SXTClassListViewController *classController = [[SXTClassListViewController alloc]init];
    classController.idDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"appSearch/searchList.do",@"URL",searchBar.text,@"ID",@"search",@"keyword", nil];
    [self.navigationController pushViewController:classController animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.goodsSearchBar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
