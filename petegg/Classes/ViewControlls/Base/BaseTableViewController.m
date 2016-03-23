//
//  BaseTableViewController.m
//  petegg
//
//  Created by ldp on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "BaseTableViewController.h"

#import "MJRefresh.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupData{
    _dataSource = [NSMutableArray array];
}

- (void)setupView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.bGroupView ? UITableViewStyleGrouped : UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_tableView];
    
    [self initRefreshView];
}

- (void)updateData
{
    [self.tableView.header beginRefreshing];
}

- (void)initRefreshView
{
    __typeof (&*self) __weak weakSelf = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 0;
        [weakSelf loadDataSourceWithPage:weakSelf.pageIndex];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ((weakSelf.pageIndex +1)*REQUEST_PAGE_SIZE == weakSelf.dataSource.count) {
            weakSelf.pageIndex++;
            [weakSelf loadDataSourceWithPage:weakSelf.pageIndex];
        }else{
            [weakSelf.tableView.footer endRefreshing];
            weakSelf.tableView.footer.hidden = YES;
        }
    }];
    
    self.tableView.footer.hidden = YES;
    [self.tableView.header beginRefreshing];
}

-(void)handleEndRefresh{
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

- (void)loadDataSourceWithPage:(int)page{
    
}


@end