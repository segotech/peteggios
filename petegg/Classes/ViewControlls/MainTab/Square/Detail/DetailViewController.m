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
#import "DetailImageCell.h"
#import "CommentInputView.h"

@interface DetailViewController()
{
    NSIndexPath *currentEditingIndexthPath;
}

@property (nonatomic, strong) UIView* userInfoView;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIView* toolView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) CommentInputView *commentInputView;

@property (nonatomic, strong) DetailModel* detailModel;
@property (nonatomic, strong) NSMutableArray* resourcesArray;

@end

const CGFloat contentLabelFontSize = 15;
NSString * const kDetailContentCellID = @"DetailContentCell";
NSString * const kDetailCommentCellID = @"DetailCommentCell";
NSString * const kDetailImageCellID = @"DetailImageCell";

@implementation DetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupData{
    [super setupData];
    
    self.resourcesArray = [NSMutableArray array];
    
    [self loadDetailInfo];
}

- (void)setupView{
    self.bGroupView = YES;
    [super setupView];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 50);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    
    [self.tableView registerClass:[DetailContentCell class] forCellReuseIdentifier:kDetailContentCellID];
    [self.tableView registerClass:[DetailCommentCell class] forCellReuseIdentifier:kDetailCommentCellID];
    [self.tableView registerClass:[DetailImageCell class] forCellReuseIdentifier:kDetailImageCellID];
    
    [self.view addSubview:self.toolView];
    
    [self.view addSubview:self.commentInputView];
    
    [self initRefreshView];
}

- (void)loadDetailInfo{
    //萌宠秀详情的接口
    [[AFHttpClient sharedAFHttpClient] querDetailWithStid:self.stid complete:^(BaseModel *model) {
        
        if (model && model.list && model.list.count > 0) {
            
            self.detailModel = model.list[0];
            
            [self.resourcesArray removeAllObjects];
            self.resourcesArray = [[self.detailModel.resources componentsSeparatedByString:@","] mutableCopy];
            
            [self.tableView reloadData];
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,2)] withRowAnimation:UITableViewRowAnimationNone];
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
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            
            [self.tableView reloadData];
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    
}

- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 49, self.tableView.width, 49)];
        _toolView.backgroundColor = LIGHT_GRAY_COLOR;
        
        //分享
        UIButton* shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        [shareBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
        }];
        
        //评论
        UIButton* commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentBtn setImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
        [commentBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [self.commentInputView showWithSendCommentBlock:^(NSString *text) {
                if (text && text.length > 0) {

                    [[AFHttpClient sharedAFHttpClient] addCommentWithPid:[AccountManager sharedAccountManager].loginModel.mid bid:@"" wid:self.stid bcid:@"" ptype:@"m" action:@"p" content:text complete:^(BaseModel *model) {
                        
                        if (model) {
                            CommentModel* addModel = [[CommentModel alloc] init];
                            addModel.memname = [AccountManager sharedAccountManager].loginModel.nickname;
                            addModel.content = text;
                            addModel.age = [AccountManager sharedAccountManager].loginModel.pet_age;
                            addModel.sex = [AccountManager sharedAccountManager].loginModel.pet_sex;
                            addModel.opttime = [AppUtil getCurrentTime];
                            addModel.race = [AccountManager sharedAccountManager].loginModel.pet_race;
                            addModel.wid = self.stid;
                            addModel.cid = model.content;
                            addModel.img = [AccountManager sharedAccountManager].loginModel.headportrait;
                            addModel.pid = [AccountManager sharedAccountManager].loginModel.mid;
                            
                            [self.dataSource insertObject:addModel atIndex:0];
                            [self.tableView reloadData];
                        }
                    }];
                }
            }];
        }];
       
        //赞
        UIButton* likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setImage:[UIImage imageNamed:@"likeBtn"] forState:UIControlStateNormal];
        [likeBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
        }];
        
        //警告
        UIButton* warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [warningBtn setImage:[UIImage imageNamed:@"warningBtn"] forState:UIControlStateNormal];
        [warningBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
        }];
        
        [_toolView sd_addSubviews:@[shareBtn, commentBtn, likeBtn, warningBtn]];
        
        _toolView.sd_equalWidthSubviews = @[shareBtn, commentBtn, likeBtn, warningBtn];
        
        shareBtn.sd_layout.leftSpaceToView(_toolView, 0).topSpaceToView(_toolView, 0).heightIs(49);
        commentBtn.sd_layout.leftSpaceToView(shareBtn, 0).topSpaceToView(_toolView, 0).heightIs(49);
        likeBtn.sd_layout.leftSpaceToView(commentBtn, 0).topSpaceToView(_toolView, 0).heightIs(49);
        warningBtn.sd_layout.leftSpaceToView(likeBtn, 0).topSpaceToView(_toolView, 0).rightSpaceToView(_toolView, 0).heightIs(49);
    }
    
    return _toolView;
}

- (CommentInputView *)commentInputView{
    
    if (!_commentInputView) {
        _commentInputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, self.view.height - [CommentInputView defaultHeight], self.view.width, [CommentInputView defaultHeight])];
    }
    
    return _commentInputView;
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
        case 2:
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
        case 2:
            return 44;
        default:
            break;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return 16;
            
        default:
            break;
    }
    return 0.0000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return self.detailModel ? 1: 0;
          
        case 0:
            return self.resourcesArray.count;
            
        case 2:
            return self.dataSource.count;
            
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            NSString* resources = self.resourcesArray[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:resources keyPath:@"model" cellClass:[DetailImageCell class] contentViewWidth:SCREEN_WIDTH];
        }
        case 1:
            return [self.tableView cellHeightForIndexPath:indexPath model:self.detailModel keyPath:@"model" cellClass:[DetailContentCell class] contentViewWidth:SCREEN_WIDTH];
        case 2:
        {
            CommentModel* model = self.dataSource[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DetailCommentCell class] contentViewWidth:SCREEN_WIDTH];
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            NSString* resources = self.resourcesArray[indexPath.row];
            
            DetailImageCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailImageCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = resources;
            
            return cell;
        }
        case 1:
        {
            DetailContentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailContentCellID];
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = self.detailModel;

            return cell;
        }
        case 2:
        {
            CommentModel* commentModel = self.dataSource[indexPath.row];
            DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCommentCellID];
            cell.replyBlock = ^(){
                currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
                [self.commentInputView showWithSendCommentBlock:^(NSString *text) {
                    if (text && text.length > 0) {
                        
                        [[AFHttpClient sharedAFHttpClient] addCommentWithPid:[AccountManager sharedAccountManager].loginModel.mid bid:commentModel.bid wid:self.stid bcid:commentModel.cid ptype:@"r" action:@"h" content:text complete:^(BaseModel *model) {
                            
                            if (model) {
                                
                                CommentModel* addModel = [[CommentModel alloc] init];
                                addModel.memname = [AccountManager sharedAccountManager].loginModel.nickname;
                                addModel.content = text;
                                addModel.opttime = [AppUtil getCurrentTime];
                                addModel.wid = self.stid;
                                addModel.cid = model.content;
                                addModel.bcid = commentModel.cid;
                                addModel.img = [AccountManager sharedAccountManager].loginModel.headportrait;
                                addModel.pid = [AccountManager sharedAccountManager].loginModel.mid;
                                
                                [commentModel.list insertObject:addModel atIndex:0];
                                [self.tableView reloadRowsAtIndexPaths:@[currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
                            }
                        }];
                    }
                }];
            };
            
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.model = commentModel;
            
            return cell;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - self.commentInputView.height, rect.size.width, self.commentInputView.height);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    self.commentInputView.frame = textFieldRect;
}


@end
