//
//  PersonalViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "PersonalViewController.h"
#import "personTableViewCell.h"

@interface PersonalViewController()

{
    UIButton * _heandBtn;
    UILabel *  _nameLabel;
    
    
    
    
}

@end

@implementation PersonalViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"tabPersonal", nil)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
// 补改xlb
- (void)viewDidLayoutSubviews
{
    
}

- (void)setupView
{
    [super setupView];
    
    // 头像
    _heandBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.view.origin.y+80, 80, 80)];
    _heandBtn.backgroundColor =[UIColor redColor];
    [_heandBtn.layer setMasksToBounds:YES];
    [_heandBtn.layer setCornerRadius:40]; //设置矩形四个圆角半径
    _heandBtn.userInteractionEnabled = YES;
    [_heandBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_heandBtn];
    /**
        点赞  名字
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    _nameLabel.text = @"我是余磊 我爱打麻将";
    _nameLabel.center = CGPointMake(self.view.center.x,_heandBtn.frame.origin.y+100);
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_nameLabel];
    
    UIImageView * message1 =[[UIImageView alloc]initWithFrame:CGRectMake(240, -20, 15,15)];
    message1.image =[UIImage imageNamed:@"while_good"];
    [self.view addSubview:message1];
    
    UILabel * goodLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, -23, 100, 20)];
    goodLabel.textColor = [UIColor grayColor];
    goodLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:goodLabel];
    

    
    

    self.tableView.frame = CGRectMake(0, _heandBtn.frame.origin.y+140, SCREEN_WIDTH, SCREEN_HEIGHT-104);
   
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    [self showBarButton:NAV_RIGHT imageName:@"new_3point.png"];
     NSArray * arrName =@[@"动态",@"录像",@"抓拍",@"关注",@"黑名单",@"逗币",@"逗码",@"权限设置",@"修改密码"];
    [self.dataSource addObjectsFromArray:arrName];
    NSArray * arrImage =@[@"person_videotape.png",@"person_photograph.png",@"person_balance.png",@"person_attention.png",@"blank_list.png",@"person_balance.png",@"person_code.png",@"person_rule.png",@"person_balance.png"];
    [self.dataSourceImage addObjectsFromArray:arrImage];
    
    
    

    
    
}
// 头像点击
- (void)headBtnClick:(UIButton *)sender
{
    
    
    
}


// 关于sego
- (void)doRightButtonTouch
{
    
    NSLog(@"1233");
    
    
}


#pragma Marr ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    switch (section) {
            
        case 0:
            
            return  3;
            
            break;
            
        case 1:
            
            return  4;
            
            break;
            
        case 2:
            return 2;
            break;
        default:
            
            return 0;
            
            break;
            
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width+3, 18)];
    [sectionView setBackgroundColor:[UIColor clearColor]];
    sectionView.layer.borderWidth =0.4;
    sectionView.layer.borderColor =GRAY_COLOR.CGColor;
    return sectionView;
}


//  设置标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  0.5;
            
            break;
            
        case 1:
            
            return  18;
            
            break;
            
        case 2:
            return 18;
            break;
        default:
            
            return 0;
            
            break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 39*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell123";
    personTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        cell = [[personTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showUserInfoCellIdentifier];
    }
    
    switch (indexPath.section) {
            
        case 0:
            // Configure the cell.
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row];
            break;
            
        case 1:
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row+3]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row+3];

            break;
            
        case 2:
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row+7]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row+7];
            break;
            
        default:
            
            break;
            
    }
    
    // 选择之后的风格
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.section) {
        case 0:
            
            if (indexPath.row == 0) {
                NSLog(@"时光轴");
            
            }
            if (indexPath.row == 1) {
                NSLog(@"录像");
                
               
                
            }
            if (indexPath.row == 2) {
                NSLog(@"抓拍");
            
                
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                
                NSLog(@"00");
               
                
            }
            if (indexPath.row == 1) {
              
            }
            
            if (indexPath.row == 2) {
                NSLog(@"11");
               
                
            }
            
            if (indexPath.row == 3) {
               
                
            }
            break;
            
        case 2:
            if (indexPath.row ==0) {
                NSLog(@"000");
                
            
                
            }
            
            
            if (indexPath.row  ==1) {
                NSLog(@"111");
                
                
            }
            
            
            break;
        default:
            break;
    }
    
    
}


@end
