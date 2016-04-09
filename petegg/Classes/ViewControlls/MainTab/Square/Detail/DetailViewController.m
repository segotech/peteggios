//
//  DetailViewController.m
//  petegg
//
//  Created by ldp on 16/4/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailViewController.h"

#import "DetailContentCell.h"
#import "DetailCommentCell.h"

@interface DetailViewController()

@property (nonatomic, strong) UIView* userInfoView;
@property (nonatomic, strong) UIView* contentView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

const CGFloat contentLabelFontSize = 15;
NSString * const kDetailContentCellID = @"DetailContentCell";
NSString * const kDetailCommentCellID = @"DetailCommentCell";

@implementation DetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)setupData{
    [super setupData];
    
    [self.tableView reloadData];
}

- (void)setupView{
    [super setupView];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.tableView registerClass:[DetailContentCell class] forCellReuseIdentifier:kDetailContentCellID];
    [self.tableView registerClass:[DetailCommentCell class] forCellReuseIdentifier:kDetailCommentCellID];
    
}

- (UIView *)userInfoView{
    if (!_userInfoView) {
        _userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 82)];
        
        UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 16, self.tableView.width, 66)];
        bgView.backgroundColor = [UIColor whiteColor];
        [_userInfoView addSubview:bgView];
        
        // 头像
        _iconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 50, 50)];
        _iconImageView.layer.cornerRadius = _iconImageView.bounds.size.width/2;
        [bgView addSubview:_iconImageView];
        
        // 名字
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake( _iconImageView.right + 8,23, self.tableView.width - _iconImageView.right - 8 - 8, 20)];
        _nameLabel.font =[UIFont systemFontOfSize:13];
        [bgView addSubview:_nameLabel];
    }
    
    return _userInfoView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return self.userInfoView;
        case 1:
        {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 60)];
            UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 16, self.tableView.width, 44)];
            bgView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:bgView];
            
            UILabel* titleLB = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, headerView.width - 8 - 8, 28)];
            titleLB.text = @"评论列表";
            [bgView addSubview:titleLB];
            
            return headerView;
        }
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.userInfoView.height;
        case 1:
            return 60;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return [self.tableView cellHeightForIndexPath:indexPath model:@"减肥减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥就" keyPath:@"model" cellClass:[DetailContentCell class] contentViewWidth:[self cellContentViewWith]];
        case 1:
            return [self.tableView cellHeightForIndexPath:indexPath model:@"减肥减减肥减肥减jfjfjfj肥就肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减减肥减肥就" keyPath:@"model" cellClass:[DetailCommentCell class] contentViewWidth:[self cellContentViewWith]];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            DetailContentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailContentCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = @"减肥减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥就";
            
            return cell;
        }
        case 1:
        {
            DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCommentCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = @"减肥减减肥减肥减jfjfjfj肥就肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减肥减肥减肥就减减肥减肥就";
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
            
        default:
            break;
    }
    return 0;
}


- (CGFloat)cellContentViewWith{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
