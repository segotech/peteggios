//
//  RecommendViewController.m
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RecommendViewController.h"

#import "AFHttpClient+Square.h"

#import "RecommendTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "sys/utsname.h"
#import "CycleScrollView.h"
#import "PersonDetailViewController.h"
#import "DetailesViewController.h"

static NSString * cellId = @"recommeCellId";

@interface RecommendViewController ()
@property (nonatomic,strong)CycleScrollView * topScrollView;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)setupView{
    [super setupView];
    _topScrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) animationDuration:3];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT);
    [self.tableView registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.tableHeaderView = _topScrollView;
    
    [self initRefreshView];
    
}

-(void)setupData{
    [super setupData];
}

- (void)loadDataSourceWithPage:(int)page {
    [[AFHttpClient sharedAFHttpClient] queryFollowSproutpetWithMid:@"MI16010000006219" pageIndex:page pageSize:REQUEST_PAGE_SIZE complete:^(BaseModel *model) {
        
        if (page == START_PAGE_INDEX) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
        } else {
            [self.dataSource addObjectsFromArray:model.list];
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.footer.hidden = YES;
        }else{
            self.tableView.footer.hidden = NO;
        }

        [self.tableView reloadData];
        [self handleEndRefresh];
        
    } failure:^{
        [self handleEndRefresh];
    }];
    
    [[AFHttpClient sharedAFHttpClient]queryRecommendWithcomplete:^(BaseModel *model) {
      //  [self.dataSourceImage addObjectsFromArray:model.list];
     //   NSLog(@"%@",self.dataSourceImage);
        [self.dataSourceImage addObjectsFromArray:model.list];
       
        [self initTopView];
    } failure:^{
        
    }];
    
}

-(void)initTopView{
    NSMutableArray * arrList =[[NSMutableArray alloc]init];
    NSMutableArray * textList =[[NSMutableArray alloc]init];
    NSMutableArray * aidList = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < self.dataSourceImage.count; i++) {
       SquareModel * model  = self.dataSourceImage[i];
        UIImageView * pImageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        [pImageView1 sd_setImageWithURL:[NSURL URLWithString:model.frontcover] placeholderImage:[UIImage imageNamed:@"segouploade.png"]];
        //[textList addObject:_imageArr[i][@"title"]];
        [textList addObject:model.title];
        [arrList addObject:pImageView1];
        [aidList addObject:model.aid] ;
    }
    _topScrollView.textArr = textList;
    _topScrollView.fetchContentViewAtIndex=  ^UIView *(NSInteger pageIndex){
        return arrList[pageIndex];
    };
    
    _topScrollView.totalPagesCount = ^NSInteger(void){
        return arrList.count;
    };
    
    _topScrollView.TapActionBlock = ^(NSInteger pagIndex){
    
        //这里写点击事件
        NSLog(@"%@",aidList[pagIndex]);
    };

}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
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
    return 370*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    //把数据给model
    SquareModel * model = self.dataSource[indexPath.row];

    //cell赋值
    cell.nameLabel.text = model.nickname;
    [cell.iconImageV.layer setMasksToBounds:YES];
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.headportrait];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];
    [cell.iconImageV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    cell.iconImageV.layer.cornerRadius = cell.iconImageV.bounds.size.width/2;
    UIButton * touchButton = [[UIButton alloc]initWithFrame:cell.iconImageV.frame];
    [touchButton addTarget:self action:@selector(iconImageVTouch:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:touchButton];
    
    
    
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"sego.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.photoView.image =[self cutImage:image];
        
    }];
    UIButton * photoViewBtn = [[UIButton alloc]initWithFrame:cell.photoView.frame];
    photoViewBtn.tag = indexPath.row + 11;
    [photoViewBtn addTarget:self action:@selector(photoButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:photoViewBtn];
    
    
    
    cell.introduceLable.text = model.content;
    
    cell.timeLable.text = model.publishtime;
    cell.leftnumber.text = model.comments;
    cell.rihttnumber.text = model.praises;
    [cell.aboutBtn addTarget:self action:@selector(attentionTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//关注按钮点击事件
-(void)attentionTouch:(UIButton * )sender{
    sender.selected = !sender.selected;

}

-(void)iconImageVTouch:(UIButton *)sender{

    PersonDetailViewController * personVc = [[PersonDetailViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
   // [self presentViewController:personVc animated:NO completion:nil];
}

-(void)photoButtonTouch:(UIButton *)sender{
    NSInteger i = sender.tag -11;

    SquareModel * model = self.dataSource[i];
    NSString * stid = model.stid;
    NSLog(@"%@",stid);

    DetailesViewController * detailVc = [[DetailesViewController alloc]init];
    stid = detailVc.stid;
    [self.navigationController pushViewController:detailVc animated:YES];


}



@end