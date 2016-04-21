//
//  PersonDetailViewController.m
//  petegg
//
//  Created by czx on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "PersonDataTableViewCell.h"
#import "AFHttpClient+PersonDate.h"
#import "AFHttpClient+Detailed.h"
#import "PersonDetailModel.h"
#import "DetailModel.h"
#import "UIImageView+WebCache.h"

static NSString * cellId = @"personDetailCellId";
@interface PersonDetailViewController ()
@property (nonatomic,strong)UIImageView * headImage; //头像
@property (nonatomic,strong)UIImageView * typeImage; //种类
@property (nonatomic,strong)UIImageView * sexImage;  //性别
@property (nonatomic,strong)UIImageView * ageImage;  //年龄
@property (nonatomic,strong)UILabel * qqLabel;       //qq
@property (nonatomic,strong)UILabel * attentionLabel;//关注数量
@property (nonatomic,strong)UILabel * fansLabel;     //粉丝数量
@property (nonatomic,strong)UILabel *autographLabel; //个性签名
@property (nonatomic,strong)UIView * topView;

@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self initUseTopView];
    
    
}

-(void)initUseTopView{
    
    PersonDetailModel * model = self.dataSource[0];
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 80 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
    [_headImage.layer setMasksToBounds:YES];
    _headImage.layer.cornerRadius = _headImage.width/2;
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.headportrait];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];
    [_headImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    [_topView addSubview:_headImage];
    
    _typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 10 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _typeImage.backgroundColor= [UIColor blackColor];
    _typeImage.layer.cornerRadius = _typeImage.width/2;
    [_topView addSubview: _typeImage];
    
    _sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 10 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _sexImage.backgroundColor = [UIColor blackColor];
    _sexImage.layer.cornerRadius = _sexImage.width/2;
    [_topView addSubview:_sexImage];
    
    _ageImage = [[UIImageView alloc]initWithFrame:CGRectMake(180 * W_Wide_Zoom, 10 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _ageImage.backgroundColor = [UIColor blackColor];
    _ageImage.layer.cornerRadius = _ageImage.width/2;
    [_topView addSubview: _ageImage];
    
    UILabel * qq = [[UILabel alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 40 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    qq.text = @"QQ:";
    qq.font = [UIFont systemFontOfSize:14];
    qq.textColor = [UIColor blackColor];
    [_topView addSubview:qq];
    
    _qqLabel = [[UILabel alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 40 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _qqLabel.text = model.qq;
    _qqLabel.font = [UIFont systemFontOfSize:14];
    _qqLabel.textColor = [UIColor blackColor];
    [_topView addSubview:_qqLabel];
    
    
    UILabel * guanzhu = [[UILabel alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 60 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    guanzhu.text = @"关注:";
    guanzhu.textColor = [UIColor blackColor];
    guanzhu.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:guanzhu];
    
    _attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _attentionLabel.text = model.gznum;
    _attentionLabel.textColor = [UIColor blackColor];
    _attentionLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_attentionLabel];
    
    
    UILabel * fensi = [[UILabel alloc]initWithFrame:CGRectMake(170 * W_Wide_Zoom, 60 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    fensi.text = @"粉丝:";
    fensi.textColor = [UIColor blackColor];
    fensi.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:fensi];
    
    _fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(210 * W_Wide_Zoom, 60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _fansLabel.text = model.fsnum;
    _fansLabel.textColor = [UIColor blackColor];
    _fansLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_fansLabel];
    
    _autographLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 90 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _autographLabel.text = model.signature;
    _autographLabel.textColor = [UIColor blackColor];
    _autographLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_autographLabel];

}

-(void)setupView{
    [super setupView];
    //这里后面要改成这用户的名字
    [self setNavTitle:@"个人中心"];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 120 * W_Hight_Zoom)];
    _topView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableHeaderView = _topView;
    [self initRefreshView];
}

-(void)setupData{
    [super setupData];
    
    [[AFHttpClient sharedAFHttpClient]querPresenWithMid:@"MI16010000006219" friend:_ddddd complete:^(BaseModel *model) {
        [self.dataSource addObjectsFromArray:model.list];
        [self initUseTopView];
    } failure:^{
        
    }];
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]querByIdSproutpetWithFriend:_ddddd pageIndex:page pageSize:REQUEST_PAGE_SIZE complete:^(BaseModel *model) {
        
        if (page == START_PAGE_INDEX) {
            [self.dataSourceImage removeAllObjects];
            [self.dataSourceImage addObjectsFromArray:model.list];
        } else {
            [self.dataSourceImage addObjectsFromArray:model.list];
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        [self.tableView reloadData];
        [self handleEndRefresh];
    } failure:^{
        [self handleEndRefresh];
    }];


    
}



#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceImage.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    DetailModel * model = self.dataSourceImage[indexPath.row];
    [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"sego.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.bigImage.image =[self cutImage:image];
    }];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end