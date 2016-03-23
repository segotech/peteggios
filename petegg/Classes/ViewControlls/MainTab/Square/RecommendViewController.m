//
//  RecommendViewController.m
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RecommendViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "RecommendTableViewCell.h"

@interface RecommendViewController ()

@end
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

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

}


-(void)setupData{
    [super setupData];
   
    NSString * str = [AppUtil getServerSego3];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"MI16010000006219" forKey:@"mid"];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"10" forKey:@"size"];
    [dic setValue:@"gz" forKey:@"ftype"];
    [dic setValue:@"up" forKey:@"type"];
    str = [str stringByAppendingString:@"clientAction.do?common=queryFollowSproutpet&classes=appinterface&method=json"];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:str parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //NSLog(@"成功数据%@",responseObject);
        responseObject = [responseObject objectForKey:@"jsondata"];
        self.dataSource = [responseObject objectForKey:@"list"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        NSLog(@"成功数据:%@",self.dataSource);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
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
    return 360*W_Hight_Zoom;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"recommeCellId";
    RecommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.nameLabel.text = self.dataSource[indexPath.row][@"nickname"];
    cell.nameLabel.backgroundColor = [UIColor blackColor];
    
    
    
    return cell;
}



@end