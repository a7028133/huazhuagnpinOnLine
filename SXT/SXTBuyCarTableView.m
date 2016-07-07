//
//  SXTBuyCarTableView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTBuyCarTableView.h"
#import "SXTBuyCarTableViewCell.h"
#import "SXTBuyCarModel.h"
@interface SXTBuyCarTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SXTBuyCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGB(245, 245, 245);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    SXTBuyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SXTBuyCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row + 1000;
    
    [cell.addButton addTarget:self action:@selector(addButtonMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.cutButton addTarget:self action:@selector(cutButtonMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.selectButton addTarget:self action:@selector(selectButtonMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.BuyCarModel = _dataArray[indexPath.row];
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        // 1. 更新数据
        [_dataArray removeObjectAtIndex:indexPath.row];
        [self returnDataArray];
        // 2. 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return @[deleteRowAction];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)addButtonMethod:(id)sender{
    UIView *cell = [[sender superview] superview];
    SXTBuyCarModel *model = _dataArray[cell.tag - 1000];
    [model setGoodsCount:model.GoodsCount+ 1];
    [self returnDataArray];
    [self reloadData];
}

- (void)cutButtonMethod:(id)sender{
    UIView *cell = [[sender superview] superview];
    SXTBuyCarModel *model = _dataArray[cell.tag - 1000];
    if (model.GoodsCount > 1) {
        [model setGoodsCount:model.GoodsCount - 1];
        [self returnDataArray];
    }
    [self reloadData];
}

- (void)selectButtonMethod:(id)sender{
    UIButton *selectButton = sender;
    UIView *cell = [[sender superview] superview];
    SXTBuyCarModel *model = _dataArray[cell.tag - 1000];
    if (selectButton.selected) {
        [model setIsSelectButton:NO];
    }else{
        [model setIsSelectButton:YES];
    }
    [self returnDataArray];
    [self reloadData];
}

- (void)returnDataArray{
    if (_dataArrayblock) {
        _dataArrayblock(_dataArray);
    }
}

@end
