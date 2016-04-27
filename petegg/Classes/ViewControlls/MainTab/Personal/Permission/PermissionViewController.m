//
//  PermissionViewController.m
//  petegg
//
//  Created by czx on 16/4/27.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PermissionViewController.h"
#import "PermissTableViewCell.h"
static NSString * cellId = @"permiss2321312321";
@interface PermissionViewController ()
@property (nonatomic,strong)UIButton * createBtn;
@end

@implementation PermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [self setNavTitle:@"访问规则"];
}

-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height );
    //  [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[PermissTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    _createBtn = [[UIButton alloc]initWithFrame:CGRectMake(40 * W_Wide_Zoom, 500 * W_Hight_Zoom, 295 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    _createBtn.backgroundColor = GREEN_COLOR;
    _createBtn.layer.cornerRadius = 5;
    [_createBtn setTitle:@"新建访问规则" forState:UIControlStateNormal];
    _createBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_createBtn];
    
    
    
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
    return 70*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PermissTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (indexPath.row == 0) {
        cell.delectBtn.hidden = YES;
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
