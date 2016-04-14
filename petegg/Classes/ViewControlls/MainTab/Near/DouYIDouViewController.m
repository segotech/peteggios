//
//  DouYIDouViewController.m
//  petegg
//
//  Created by czx on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DouYIDouViewController.h"
#import "NearTableViewCell.h"
#import "NearbyModel.h"
#import "AFHttpClient+Nearby.h"
#import "UIImageView+WebCache.h"
static NSString * cellId = @"douyidouCellId";
@interface DouYIDouViewController ()

@end

@implementation DouYIDouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逗一逗";
    self.view.backgroundColor = [UIColor redColor];
}

-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height );
    //  [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[NearTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];
}


-(void)setupData{
    [super setupData];
  
    
    
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]queriCanVisitWithMid:[AccountManager sharedAccountManager].loginModel.mid pageIndex:page pageSize:REQUEST_PAGE_SIZE complete:^(BaseModel *model) {
        if (page == START_PAGE_INDEX) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
        } else {
            [self.dataSource addObjectsFromArray:model.list];
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        [self.tableView reloadData];
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
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NearbyModel * model = self.dataSource[indexPath.row];
    
    cell.nameLabel.text = model.nickname;
    
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.headportrait];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];
    [cell.headBtn sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    cell.signLabel.text = model.signature;

    

    cell.rightBtn.backgroundColor = [UIColor whiteColor];
    [cell.rightBtn setTitle:@"互动" forState:UIControlStateNormal];
    [cell.rightBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
