//
//  SXTMyTableView.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "SXTMyTableView.h"
#import "SXTMyTableViewCell.h"


@interface SXTMyTableView()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)   UIView *exitFootView;              /** 推出view */
@property (strong, nonatomic)   UIButton *exitButton;              /** 退出按钮  */
@end

@implementation SXTMyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.backgroundColor = RGB(245, 245, 245);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (isLogin.count != 0) {
        return 6;
    }else
        return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    
    SXTMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SXTMyTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellSource = self.dataArray[indexPath.row];
    if (indexPath.row == 3) {
        UIImageView *nextImage = [cell valueForKey:@"nextImage"];
        nextImage.hidden = YES;
        UILabel *phoneNumber = [[UILabel alloc]init];
        phoneNumber.textColor = [UIColor grayColor];
        phoneNumber.text = @"4006668800";
        [cell addSubview:phoneNumber];
        __weak typeof(cell) weakCell = cell;
        [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakCell.mas_right).offset(-15);
            make.size.equalTo(CGSizeMake(110, 15));
            make.centerY.equalTo(weakCell.mas_centerY);
        }];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 35.0)];
    headerView.backgroundColor = RGB(245, 245, 245);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"ISLOGIN"];
    if (isLogin.count != 0){
        return 120.0;
    }else
        return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"ISLOGIN"];
    if (isLogin.count != 0) {
        return self.exitFootView;
    }else
        return nil;
}

- (UIView *)exitFootView{
    if (!_exitFootView) {
        _exitFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 120)];
        _exitFootView.backgroundColor = RGB(245, 245, 245);
        [_exitFootView addSubview:self.exitButton];
        
    }
    return _exitFootView;
}

- (UIButton *)exitButton{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _exitButton.frame = CGRectMake(50, 40, VIEW_WIDTH-100, 40);
        _exitButton.backgroundColor = RGB(67, 182, 245);
        _exitButton.layer.masksToBounds = YES;
        _exitButton.layer.cornerRadius = 5.0;
        [_exitButton setTitle:@"退  出  登  录" forState:(UIControlStateNormal)];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_exitButton addTarget:self action:@selector(exitButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _exitButton;
}

- (void)exitButtonMethod{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ISLOGIN"];
    if (_exitBlock) {
        _exitBlock();
    }
    [self reloadData];
}

@end

















