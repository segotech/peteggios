//
//  BalckListViewController.m
//  petegg
//
//  Created by czx on 16/4/27.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BalckListViewController.h"
#import "BalckListTableViewCell.h"
#import "AFHttpClient+ChangepasswordAndBlacklist.h"
#import "BlackListModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
static NSString * cellId = @"balack12232132131";
@interface BalckListViewController ()

@end

@implementation BalckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavTitle:@"黑名单"];
    [self showBarButton:NAV_RIGHT title:@"ceshi" fontColor:[UIColor blackColor]];
}
//iOS自带的分享功能，能直接分享图片，链接等信息
//-(void)doRightButtonTouch{
//    //分享链接
//    NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
//    
//    UIImage *imageToShare = [UIImage imageNamed:@"egg_login.jpg"];
//    
//    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
//    
//    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
//    
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
//                                        applicationActivities:nil];
//    //不出现在活动项目
//   // activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                       //  UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
//    [self presentViewController:activityVC animated:YES completion:nil];
//    
//
//}










-(void)setupView{
    [super  setupView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.tableView registerClass:[BalckListTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
}

-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]queryBlacklistWithMid:[AccountManager sharedAccountManager].loginModel.mid complete:^(BaseModel *model) {
        if (model) {
            [self.dataSource addObjectsFromArray:model.list];
            [self.tableView reloadData];
        }
        
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
    BlackListModel * model = self.dataSource[indexPath.row];
    
    BalckListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.nameLabel.text = model.nickname;
    cell.signLabel.hidden = YES;
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.headportrait];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];
    [cell.headBtn sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"segofbf1.png"]];

    
    cell.rightBtn.layer.cornerRadius = 5;
    [cell.rightBtn setTitle:@"移除" forState:UIControlStateNormal];
    cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    cell.rightBtn.tag = indexPath.row + 1234;
    [cell.rightBtn addTarget:self action:@selector(yichuButtontouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)yichuButtontouch:(UIButton *)sender{
    NSInteger i = sender.tag -1234;
    BlackListModel * model = self.dataSource[i];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要把ta移除黑名单吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[AFHttpClient sharedAFHttpClient]delBlacklistWithMid:[AccountManager sharedAccountManager].loginModel.mid friend:model.friend complete:^(BaseModel *model) {
            [[AppUtil appTopViewController] showHint:model.retDesc];
            [self setupData];
            
        }];
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
 



}
//左滑删除
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{
    //昨滑的文字
    return@"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    //让它能够滑动
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除的属性
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       // NSUInteger row = [indexPath row];
       // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
         //                withRowAnimation:UITableViewRowAnimationAutomatic];
       // [tableView reloadData];
        // 数据源也要相应删除一项
         BlackListModel * model = self.dataSource[indexPath.row];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要把ta移除黑名单吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[AFHttpClient sharedAFHttpClient]delBlacklistWithMid:[AccountManager sharedAccountManager].loginModel.mid friend:model.friend complete:^(BaseModel *model) {
                [[AppUtil appTopViewController] showHint:model.retDesc];
                [self setupData];
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.tableView reloadData];
        }]];
         [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
