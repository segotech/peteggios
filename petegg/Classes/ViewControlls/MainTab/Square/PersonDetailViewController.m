//
//  PersonDetailViewController.m
//  petegg
//
//  Created by czx on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "PersonDataTableViewCell.h"
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
    [self initUseTopView];
    
}

-(void)initUseTopView{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 80 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
    _headImage.backgroundColor = [UIColor blackColor];
    _headImage.layer.cornerRadius = _headImage.width/2;
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
    _qqLabel.text = @"2432143434";
    _qqLabel.font = [UIFont systemFontOfSize:14];
    _qqLabel.textColor = [UIColor blackColor];
    [_topView addSubview:_qqLabel];
    
    
    UILabel * guanzhu = [[UILabel alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 60 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    guanzhu.text = @"关注:";
    guanzhu.textColor = [UIColor blackColor];
    guanzhu.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:guanzhu];
    
    _attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake(140 * W_Wide_Zoom, 60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _attentionLabel.text = @"33";
    _attentionLabel.textColor = [UIColor blackColor];
    _attentionLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_attentionLabel];
    
    
    UILabel * fensi = [[UILabel alloc]initWithFrame:CGRectMake(170 * W_Wide_Zoom, 60 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    fensi.text = @"粉丝:";
    fensi.textColor = [UIColor blackColor];
    fensi.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:fensi];
    
    _fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(210 * W_Wide_Zoom, 60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _fansLabel.text = @"44";
    _fansLabel.textColor = [UIColor blackColor];
    _fansLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_fansLabel];
    
    _autographLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 90 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _autographLabel.text = @"这是我的好朋友，嘻嘻嘻!";
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
    
    self.tableView.frame = CGRectMake(0, NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT, self.view.width, self.view.height- NAV_BAR_HEIGHT- STATUS_BAR_HEIGHT);
    [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableHeaderView = _topView;
   // [self initRefreshView];
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
    return 310*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    
    
    return cell;
}

@end
