//
//  NearbyPeopleViewController.m
//  petegg
//
//  Created by czx on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NearbyPeopleViewController.h"
#import "NearTableViewCell.h"
static NSString * cellId = @"111111111111";
@interface NearbyPeopleViewController ()

@end

@implementation NearbyPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近";
    self.view.backgroundColor = [UIColor blackColor];
    
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

    
    
    
    [cell.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cell.rightBtn.layer.cornerRadius = 5;
    [cell.rightBtn setTitle:@"+关注" forState:UIControlStateNormal];
    cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


@end
