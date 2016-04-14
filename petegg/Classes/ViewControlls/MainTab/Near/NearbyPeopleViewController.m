//
//  NearbyPeopleViewController.m
//  petegg
//
//  Created by czx on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NearbyPeopleViewController.h"
#import "NearTableViewCell.h"
#import "AFHttpClient+Nearby.h"
#import "NearbyModel.h"
#import "UIImageView+WebCache.h"

static NSString * cellId = @"111111111111";
@interface NearbyPeopleViewController ()

@end

@implementation NearbyPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近";
    self.view.backgroundColor = [UIColor blackColor];
    
}

-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height );
  //  [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[NearTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  //  [self initRefreshView];
    
}

-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]querNeighborhoodWithMid:[AccountManager sharedAccountManager].loginModel.mid pageIndex:1 pageSize:REQUEST_PAGE_SIZE complete:^(BaseModel *model) {
//        if (page == START_PAGE_INDEX) {
//            [self.dataSource removeAllObjects];
//            [self.dataSource addObjectsFromArray:model.list];
//        } else {
//            [self.dataSource addObjectsFromArray:model.list];
//        }
//        
//        if (model.list.count < REQUEST_PAGE_SIZE){
//            self.tableView.footer.hidden = YES;
//        }else{
//            self.tableView.footer.hidden = NO;
//        }
        [self.dataSource addObjectsFromArray:model.list];
        [self.tableView reloadData];
       // [self handleEndRefresh];
    }];
}

-(void)loadDataSourceWithPage:(int)page{
 


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
    
    
    [cell.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     cell.rightBtn.layer.cornerRadius = 5;
    [cell.rightBtn setTitle:@"+关注" forState:UIControlStateNormal];
    cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


@end
