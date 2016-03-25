//
//  AttentionViewController.m
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AttentionViewController.h"
#import "RecommendTableViewCell.h"
#import "AFHttpClient+Square.h"
#import "UIImageView+WebCache.h"
static NSString * cellId = @"AttentionCellId";
@interface AttentionViewController ()

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)setupView{
    [super setupView];
     self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT);
    [self.tableView registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = GRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];
    
}

-(void)setupData{
    [super setupData];
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient] querySproutpetWithMid:@"MI16010000006219" pageIndex:page pageSize:REQUEST_PAGE_SIZE complete:^(SquareListModel *model) {
        if (page == 1) {
            [self.dataSource addObjectsFromArray:model.list];
        }else{
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
        }
        [self.tableView reloadData];
        [self handleEndRefresh];
    } failure:^{
        
    }];

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
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"sego.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.photoView.image =[self cutImage:image];
    }];
    cell.introduceLable.text = model.content;
    
    cell.timeLable.text = model.publishtime;
    cell.leftnumber.text = model.comments;
    cell.rihttnumber.text = model.praises;
    
    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




@end
