//
//  SXTTimeHomeTableview.m
//  SXT
//
//  Created by 赵金鹏 on 16/3/31.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTTimeHomeTableview.h"
#import "SXTSingleTableViewCell.h"//单品列表cell
#import "SXTGroupBuyTableViewCell.h"//品牌列表cell

@implementation SXTTimeHomeTableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据isSingle的值来设定对应cell的个数
    if (_isSingle) {
        return _singleListArray.count;
    }else{
        return _groupBuyListArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //根据isSingle的值来设定对应cell的高度
    if (_isSingle) {
        return 170;
    }else
        return 175;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    //根据isSingle的值来判断显示哪一个cell
    if (_isSingle) {
        SXTSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SXTSingleTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.singleList = self.singleListArray[indexPath.row];
        return cell;

    }else{
        SXTGroupBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SXTGroupBuyTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.groupBuyModel = self.groupBuyListArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSingle) {
        if (_singleBlock) {
            NSString *goodsID = [self.singleListArray[indexPath.row] GoodsId];
            _singleBlock(goodsID);
        }
    }else{
        if (_groupBlock) {
            NSString *ActivityId = [self.groupBuyListArray[indexPath.row] ActivityId];
            _groupBlock(ActivityId);
        }
    }
}
@end






