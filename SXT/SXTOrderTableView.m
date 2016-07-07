//
//  SXTOrderTableView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTOrderTableView.h"
#import "SXTSureOrderTableViewCell.h"
#import "SXTOrderAddressTableViewCell.h"
@interface SXTOrderTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SXTOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.backgroundColor = RGB(245, 245, 245);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else
        return _orderDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 65.0;
    }else
        return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellID = @"addressCell";
        SXTOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SXTOrderAddressTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else{
        static NSString *cellID = @"orderCell";
        SXTSureOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SXTSureOrderTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.orderCellrModel = _orderDataArray[indexPath.row];
        return cell;
    }
}


@end
