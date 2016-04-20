//
//  PersonNewAttentionViewController.m
//  petegg
//
//  Created by czx on 16/4/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonNewAttentionViewController.h"
#import "PersonNewAttentionTableViewCell.h"
#import "AFHttpClient+PersonAttention.h"
#import "PersonAttention.h"
#import "PersonAttentionTableViewCell.h"
static NSString * cellId = @"personNewAttentionTableViewCellidddd";

@interface PersonNewAttentionViewController ()

@end

@implementation PersonNewAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"新关注"];
}
-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, 667 * W_Hight_Zoom);
    [self.tableView registerClass:[PersonAttentionTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // [self initRefreshView];
    self.tableView.mj_footer.hidden = YES;
}


-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]focusTipWithMid:[AccountManager sharedAccountManager].loginModel.mid complete:^(BaseModel *model) {
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
    PersonAttention * model = self.dataSource[indexPath.row];
    PersonAttentionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.nameLabel.text = model.nickname;
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.headportrait];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];

    
    [cell.headImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    if ([model.pet_race isEqualToString:@"汪"]) {
        cell.kindImage.image = [UIImage imageNamed:@"wangwang.png"];
    }else{
        cell.kindImage.image = [UIImage imageNamed:@"miaomiao.png"];
    }
    if ([model.pet_sex isEqualToString:@"公"]) {
        cell.sexImage.image = [UIImage imageNamed:@"manquanquan.png"];
    }else{
        cell.sexImage.image = [UIImage imageNamed:@"womanquanquan.png"];
    }
    NSString * age = [NSString stringWithFormat:@"%@岁",model.pet_age];
    [cell.ageButton setTitle:age forState:UIControlStateNormal];
    
    return cell;
}




@end