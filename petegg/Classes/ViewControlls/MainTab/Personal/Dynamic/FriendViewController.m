//
//  FriendViewController.m
//  petegg
//
//  Created by yulei on 16/4/10.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TimeHistoryModel.h"
#import "MessageViewController.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

@synthesize headImageView;
@synthesize nameLabel;
@synthesize message;




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"tabFriend", nil)];
}


- (void)setupData
{
    
    [super setupData];
}
- (void)setupView
{
    [super setupView];
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 60, 60)];
    headImageView.image =[UIImage imageNamed:@"DouYiDou.png"];
    [headImageView.layer setMasksToBounds:YES];
    [headImageView.layer setCornerRadius:30.0]; //设置矩形四个圆角半径
    headImageView.userInteractionEnabled  = YES;
    [self.view addSubview:headImageView];
    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handButton:)];
    headImageView.userInteractionEnabled = YES;
    [headImageView addGestureRecognizer:tapIcon];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 90, 200, 30)];
    nameLabel.text =@"Mr.Nobody";
    nameLabel.font =[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    self.tableView.frame =CGRectMake(20, 130,MainScreen.width-25, MainScreen.height-130);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // message
    
    message =[[UIButton alloc]initWithFrame:CGRectMake(170, 80, 140, 30)];
    [message addTarget:self action:@selector(messageBtn:) forControlEvents:UIControlEventTouchUpInside];
     message.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);//设置title在button上的位
    [message setBackgroundImage:[UIImage imageNamed:@"moveing.png"] forState:UIControlStateNormal];
    [message setTitle:@"4条动态" forState:UIControlStateNormal];
    [message setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    message.titleLabel.font =[UIFont systemFontOfSize:13];
    [self.view addSubview:message];
    
    
    [self initRefreshView];
    
    
    
}



- (void)loadDataSourceWithPage:(int)page
{
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
    [dicc setValue:@"1" forKey:@"page"];
    [dicc setValue:@"10" forKey:@"size"];
    [dicc setValue:@"MI16010000005868" forKey:@"mid"];

    NSString * service =[NSString stringWithFormat:@"clientAction.do?common=queryTrend&classes=appinterface&method=json"];
    [AFNetWorking postWithApi:service parameters:dicc success:^(id json) {
        json = [json objectForKey:@"jsondata"] ;
        NSArray * arrStr =[json[@"content"] componentsSeparatedByString:@","];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:arrStr[0]] placeholderImage:[UIImage imageNamed:@"DouYiDou.png"]];
        nameLabel.text = arrStr[1];
        
            NSArray *array = [json objectForKey:@"list"];
        
        if (array.count > 0) {
            for (NSDictionary *dic0 in array) {
                TimeHistoryModel *model = [[TimeHistoryModel alloc] init];
                [model setValuesForKeysWithDictionary:dic0];
                [self.dataSource addObject:model];
            }
            
        }else{
            
            self.tableView.hidden = YES;
        }
        
        if (page == START_PAGE_INDEX) {
         //   [self.dataSource removeAllObjects];
        }else
        {
            
        }
      
        
        [self.tableView reloadData];
        [self handleEndRefresh];
        
        
    } failure:^(NSError *error) {
        
        [self handleEndRefresh];
        
    }];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  头像点击
 */
- (void)handButton:(UITapGestureRecognizer *)sender
{

    
}

/**
 *  消息点击
 */

- (void)messageBtn:(UIButton *)sender
{
    
    MessageViewController *messageVC =[[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
    [self.navigationController pushViewController:messageVC animated:YES];
    
    
}



#pragma mark   ---------tableView协议----------------

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
    return 205;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    TimeHistoryModel *model;
    if (self.dataSource.count>0) {
        model = self.dataSource[indexPath.row];
    }
    
    static NSString *CellId = @"PetNewsCell";
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendTableViewCell" owner:self options:nil]lastObject];
    }

    cell.tellLable.text =@"0";

    cell.tellLable.text = model.content;
    cell.timeLable.text = model.publishtime;
    cell.goodLabel.text = model.praises;
    cell.commentsLabel.text = model.comments;
    
    // 图片
    cell.oneImagev.image= nil;
    cell.twotwoImage.image = nil;
    cell.twoOneImage.image = nil;
    
    NSInteger i = 0;
    NSArray * array;
    if (![AppUtil isBlankString:model.resources]) {
        array = [model.resources componentsSeparatedByString:@","];
        i = array.count;
        
    }
    if (i ==1) { // 一张图
         //视频
        if ([model.type isEqualToString:@"v"]) {
            [cell.oneImagev sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"默认头像2副本.png"]];
            
        }else  // 图
        {
              [cell.oneImagev sd_setImageWithURL:[NSURL URLWithString:model.resources] placeholderImage:[UIImage imageNamed:@"默认头像2副本.png"]];
        }
        
    }else if (i>=2)// 两张图
    {
        
            [cell.twoOneImage sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"默认头像2副本.png"]];
        
            [cell.twotwoImage sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"默认头像2副本.png"]];
        
        
    }
    
    

    cell.deleteBtn.userInteractionEnabled = YES;
    [cell.deleteBtn addTarget:self action:@selector(deleteImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    

    
}


// 删除事件

- (void)deleteImageBtn:(UIButton *)sender
{
    
   NSInteger  h = [self.tableView indexPathForCell:((FriendTableViewCell*)sender.superview.superview)].row;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",self.dataSource[indexPath.row]);
    
    
    
}

@end
