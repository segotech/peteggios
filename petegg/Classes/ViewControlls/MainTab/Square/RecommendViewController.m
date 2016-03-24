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


static NSString * cellId = @"recommeCellId";

@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)setupView{
    [super setupView];
    
    self.tableView.frame = self.view.frame;
    [self.tableView registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:cellId];
    
}


-(void)setupData{
    [super setupData];
}

- (void)loadDataSourceWithPage:(int)page type:(NSString *)type{
    [[AFHttpClient sharedAFHttpClient] queryFollowSproutpetWithMid:@"MI16010000006219" pageIndex:0 pageSize:REQUEST_PAGE_SIZE ftype:@"gz" type:type complete:^(RecommendListModel *model) {
        if ([type isEqualToString:@"up"]) {
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
    return 360*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    RecommendModel * model = self.dataSource[indexPath.row];
    
    cell.nameLabel.text = model.nickname;
  //cell.nameLabel.backgroundColor = [UIColor blackColor];
    
    
    
    return cell;
}



@end