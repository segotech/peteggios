//
//  TransactiondetailViewController.m
//  petegg
//
//  Created by czx on 16/5/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "TransactiondetailViewController.h"
#import "TransaceTableViewCell.h"
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
    
}
#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransaceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    return cell;
}


@end
