//
//  DetailViewController.m
//  petegg
//
//  Created by ldp on 16/4/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailViewController.h"

#import "AFHttpClient+Detailed.h"

#import "UIImageView+WebCache.h"

#import "DetailContentCell.h"
#import "DetailCommentCell.h"

@interface DetailViewController()

@property (nonatomic, strong) UIView* userInfoView;
@property (nonatomic, strong) UIView* contentView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) DetailModel* detailModel;
@property (nonatomic, strong) NSMutableArray* resourcesArray;

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
    
    self.resourcesArray = [NSMutableArray array];
    
    [self loadDetailInfo];
    
}

- (void)setupView{
    self.bGroupView = YES;
    [super setupView];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    
    [self.tableView registerClass:[DetailContentCell class] forCellReuseIdentifier:kDetailContentCellID];
    [self.tableView registerClass:[DetailCommentCell class] forCellReuseIdentifier:kDetailCommentCellID];
    
    [self initRefreshView];
}

- (void)loadDetailInfo{
    //萌宠秀详情的接口
    [[AFHttpClient sharedAFHttpClient] querDetailWithStid:self.stid complete:^(BaseModel *model) {
        
        if (model && model.list && model.list.count > 0) {
            
            self.detailModel = model.list[0];
            
//            [self.resourcesArray removeAllObjects];
//            self.resourcesArray = [[self.detailModel.resources componentsSeparatedByString:@","] mutableCopy];
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]queryCommentWithWid:_stid pageIndex:page pageSize:REQUEST_PAGE_SIZE complete:^(BaseModel *model) {
        
        [self handleEndRefresh];
        
        if (model) {
            if (page == START_PAGE_INDEX) {
                [self.dataSource removeAllObjects];
            }

            [self.dataSource addObjectsFromArray:model.list];
            
            if (model.list.count < REQUEST_PAGE_SIZE){
                self.tableView.footer.hidden = YES;
            }else{
                self.tableView.footer.hidden = NO;
            }
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    
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
        _iconImageView.layer.masksToBounds = YES;
        [bgView addSubview:_iconImageView];
        
        // 名字
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake( _iconImageView.right + 8,23, self.tableView.width - _iconImageView.right - 8 - 8, 20)];
        _nameLabel.font =[UIFont systemFontOfSize:13];
        [bgView addSubview:_nameLabel];
    }
    
    if (self.detailModel) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.headportrait] placeholderImage:nil];
        _nameLabel.text = self.detailModel.nickname;
    }
    
    return _userInfoView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return self.userInfoView;
        case 1:
        {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
            headerView.backgroundColor = [UIColor whiteColor];
            
            UILabel* titleLB = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, headerView.width - 8 - 8, 28)];
            titleLB.text = @"评论列表";
            [headerView addSubview:titleLB];
            
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
            return self.detailModel ? self.userInfoView.height : 0;
        case 1:
            return 44;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 16;
            
        default:
            break;
    }
    return 0.0000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.detailModel ? 1: 0;
        case 1:
            return self.dataSource.count;
            
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
            return [self.tableView cellHeightForIndexPath:indexPath model:self.detailModel keyPath:@"model" cellClass:[DetailContentCell class] contentViewWidth:[self cellContentViewWith]];
        case 1:
        {
            CommentModel* model = self.dataSource[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DetailCommentCell class] contentViewWidth:[self cellContentViewWith]];
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            DetailContentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailContentCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = self.detailModel;

            return cell;
        }
        case 1:
        {
            CommentModel* model = self.dataSource[indexPath.row];
            DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCommentCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = model;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
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
