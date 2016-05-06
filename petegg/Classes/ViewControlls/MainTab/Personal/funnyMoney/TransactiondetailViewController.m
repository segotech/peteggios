//
//  TransactiondetailViewController.m
//  petegg
//
//  Created by czx on 16/5/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "TransactiondetailViewController.h"
#import "TransaceTableViewCell.h"
#import "AFHttpClient+ChangepasswordAndBlacklist.h"
#import "TransactionRecordModel.h"
static NSString * cellId = @"transactiondetailcellidd";
@interface TransactiondetailViewController ()

@end

@implementation TransactiondetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"明细"];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.tableView registerClass:[TransaceTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
}

-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]getTransactionRecordWithMid:[AccountManager sharedAccountManager].loginModel.mid  complete:^(BaseModel *model) {
        [self.dataSource addObjectsFromArray:model.list];
        [self.tableView reloadData];

    }];
}
#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransactionRecordModel * model = self.dataSource[indexPath.row];
    TransaceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSString * jiahao = @"+";
    NSString * jianhao = @"-";
    if ([model.type isEqualToString:@"out"]) {
        cell.runAccoun.text = @"支出";
        cell.runAccounNumber.text = [jianhao stringByAppendingString:model.money];
         cell.runAccounNumber.textColor = [UIColor redColor];
    }else{
        cell.runAccoun.text = @"收入";
         cell.runAccounNumber.text = [jiahao stringByAppendingString:model.money];
        cell.runAccounNumber.textColor = [UIColor greenColor];
    }
    cell.money.text = model.object;
    cell.data.text = model.opttime;
    
    
    
    
    
    
    
    
    return cell;
}


@end
