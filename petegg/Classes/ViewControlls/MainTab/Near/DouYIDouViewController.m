//
//  DouYIDouViewController.m
//  petegg
//
//  Created by czx on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DouYIDouViewController.h"
#import "NearTableViewCell.h"

static NSString * cellId = @"douyidouCellId";
@interface DouYIDouViewController ()

@end

@implementation DouYIDouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逗一逗";
    self.view.backgroundColor = [UIColor redColor];
}

-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height );
    //  [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[NearTableViewCell class] forCellReuseIdentifier:cellId];
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
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    
    
    
    
    cell.rightBtn.backgroundColor = [UIColor whiteColor];
    [cell.rightBtn setTitle:@"互动" forState:UIControlStateNormal];
    [cell.rightBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
