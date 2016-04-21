//
//  VideoViewController.m
//  petegg
//
//  Created by yulei on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "VideoViewController.h"
#import "MyVideoCollectionViewCell.h"
#import "VideoModel.h"
#import "AFNetWorking.h"
#import "UIImageView+WebCache.h"


static NSString *kfooterIdentifier = @"footerIdentifier";
static NSString *kheaderIdentifier = @"headerIdentifier";
@interface VideoViewController ()
{
    
    BOOL isSelet;
    NSString *statsIdentifi;
    
    // 选择上传或者删除数组
    NSMutableArray * deleteOrUpdateArr;
    
    NSTimer * timer;
    AppDelegate *app;


    
    
}

@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * rightButton;
@property(nonatomic,strong)UILabel * lineLabel;
@property(nonatomic,strong)UIImageView * deleteImageV;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)UIButton * updataBtn;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property(nonatomic,strong)UIProgressView * proAccuracy;


@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"videoTitle", nil)];
    
   
    
}

// 界面初始化
- (void)setupView
{
    [super setupView];
     app= (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 选择按钮
    isSelet = YES;
    [self showBarButton:NAV_RIGHT imageName:@"selecting.png"];
    
    // collection
    self.collection.frame = CGRectMake(10, 110, SCREEN_WIDTH-20, SCREEN_HEIGHT-110);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator   = NO;
    [self.collection registerClass:[MyVideoCollectionViewCell class] forCellWithReuseIdentifier:@"imageId"];
    [self.collection registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    [self.collection registerNib:[UINib nibWithNibName:@"HeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    self.collection.backgroundColor = [UIColor whiteColor];
    
    
    
    
    // 已上传  未上传
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 50)];
    _leftButton =[[UIButton alloc]initWithFrame:CGRectMake(60 , 10, 60 , 30 )];
    [_leftButton setTitle:NSLocalizedString(@"hadupdata", nil) forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftButton setTitleColor:GREEN_COLOR forState:UIControlStateSelected];
    _leftButton.selected = YES;
    
    [_leftButton addTarget:self action:@selector(leftbuttonTouch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_leftButton];
    
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 34, 40, 1)];
    _lineLabel.backgroundColor = GREEN_COLOR;
    [topView addSubview:_lineLabel];
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 10, 60, 30)];
    [_rightButton setTitle:NSLocalizedString(@"willupdata", nil) forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:GREEN_COLOR forState:UIControlStateSelected];
    _rightButton.selected = NO;
    [topView addSubview:_rightButton];
    [_rightButton addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    // 删除  上传
    _deleteImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, MainScreen.height-45, MainScreen.width, 45)];
    _deleteImageV.userInteractionEnabled = YES;
    _deleteImageV.hidden = YES;
    _deleteImageV.backgroundColor =[UIColor whiteColor];
    _deleteImageV.layer.borderWidth =1;
    _deleteImageV.layer.borderColor =GRAY_COLOR.CGColor;
    
    [self.view addSubview:_deleteImageV];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(_deleteImageV.center.x-15, 5, 30, 30);
    [_deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(onDeleBt:) forControlEvents:UIControlEventTouchUpInside];
    
    [_deleteImageV addSubview:_deleteBtn];
    
    // 左滑 右滑
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    // 进度条
    
    self.proAccuracy=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.proAccuracy.frame=CGRectMake(0, 65, 375, 100);
    self.proAccuracy.trackTintColor=[UIColor blackColor];
    self.proAccuracy.progress=0.0;
    self.proAccuracy.progressTintColor=GREEN_COLOR;

    //设置进度值并动画显示
    [self.proAccuracy setProgress:0.0 animated:YES];
    [self.view addSubview:self.proAccuracy];

    [self initRefreshView:@"1"];
    

}

        //**********************点击事件******************************\\

/**
 *  选择按钮点击
 */
- (void)doRightButtonTouch
{
    
    [deleteOrUpdateArr removeAllObjects];
    if (isSelet) {
        [self showBarButton:NAV_RIGHT imageName:@"cancel.png"];
        isSelet = NO;
        _deleteImageV.hidden = NO;

    }else{
        for (int i=0; i<self.dataSource.count; i++) {
            VideoModel *model = self.dataSource[i];
            NSArray *imageA = [model.filename componentsSeparatedByString:@","];
            
            for (int j=0; j<imageA.count; j++) {
        MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
        cell.rightBtn.hidden = YES;
        cell.rightBtn.selected = NO;
        }
    }
          [self showBarButton:NAV_RIGHT imageName:@"selecting.png"];
         isSelet = YES;
        _deleteImageV.hidden = YES;
        
}
   
    if ([statsIdentifi isEqualToString:@"1"]) {
        [_deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        
    }else if ([statsIdentifi isEqualToString:@"0"]){
        [_deleteBtn setImage:[UIImage imageNamed:@"update.png"] forState:UIControlStateNormal];
        
    }
    
}
/**
 *  删除按钮点击
 */

-(void)onDeleBt:(UIButton *)sender
{
    if (deleteOrUpdateArr.count ==1) {
    NSUserDefaults * standDefauls =[NSUserDefaults standardUserDefaults];
    if (![AppUtil isBlankString:[standDefauls objectForKey:@"content"]]) {
        
        
        [self showMessageWarring:@"还有视频正在上传" view:app.window];
        
    }else{
    
    NSMutableString *deleStr = [[NSMutableString alloc]init];
    NSString *str = [NSString stringWithFormat:@"%@",deleteOrUpdateArr[0]];
    [deleStr appendFormat:@"%@",str];
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
    NSString * service =[NSString stringWithFormat:@"clientAction.do?common=uploadVideo&classes=appinterface&method=json&filename=%@&mid=%@&termid=%@&deviceno=%@",deleStr,@"MI15120000001582",@"216",@"73000020097"];
    
   [AFNetWorking postWithApi:service parameters:dicc success:^(id json) {
       
       NSLog(@"%@",json);
       
       /**
        *  存取查询开始时间
        */
       NSDictionary *dic1 = [json objectForKey:@"jsondata"] ;
       [standDefauls setObject:[AppUtil getNowTime] forKey:@"endTime"];
       [standDefauls setObject:dic1[@"content"] forKey:@"content"];
      
       
       
      [standDefauls synchronize];
       
       
       if([[dic1 objectForKey:@"retCode"] isEqualToString:@"0000"]){
        // 提取视频编号
           [self showSuccessHudWithHint:[dic1 objectForKey:@"retDesc"]];
        NSString  * trdID = dic1[@"content"];
           // 检查视频上传状态
           timer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(checkVideoStats:) userInfo:trdID repeats:YES];
           [timer setFireDate:[NSDate distantPast]];
           
           
       }else
       {
           
        // 上传命令 失败
           NSString * str =[dic1 objectForKey:@"retDesc"];
        [self showSuccessHudWithHint:str];

           
       }
       
   } failure:^(NSError *error) {
       
        // 上传命令 失败
       
   }];
    
    }
        isSelet = YES;
        _deleteImageV.hidden = YES;
        [self showBarButton:NAV_RIGHT imageName:@"selecting.png"];
        
    }else if (deleteOrUpdateArr.count ==0)
    {
        
    [self showMessageWarring:@"没有选择视频哦" view:app.window];
        
    }else
    {
        
    [self showMessageWarring:@"一次只能选择一个视频上传哦" view:app.window];
    }
        
   
    
    
    
}

// 左滑右滑点击

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self rightButtonTouch];
     }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self leftbuttonTouch];
    }
}


// 数据初始化
- (void)setupData
{
    [super setupData];
    deleteOrUpdateArr =[[NSMutableArray alloc]init];
    statsIdentifi =@"1";
   
    
}

// 请求数据
- (void)data:(NSString *)stateNum
{
    
    NSString * str =@"clientAction.do?method=json&common=getVideo&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:@"MI15120000001582" forKey:@"mid"];
    [dic setValue:stateNum forKey:@"status"];
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        [self handleEndRefresh];
        json = [[json objectForKey:@"jsondata"]objectForKey:@"list"];
        NSMutableArray * arr =[[NSMutableArray alloc]init];
        [arr addObjectsFromArray:json];
        for (NSDictionary *dic0 in arr) {
            VideoModel *model = [[VideoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic0];
            [self.dataSource addObject:model];
            
        }
        [self handleEndRefresh];
        NSLog(@"====%@",json);
        
        [self.collection reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)checkVideoStats:(NSTimer *)tid
{
  
    
    
    self.proAccuracy.progress= self.proAccuracy.progress+0.1;
    NSString * service =[NSString stringWithFormat:@"clientAction.do?common=queryTask&classes=appinterface&method=json&tid=%@",tid.userInfo];
    [AFNetWorking postWithApi:service parameters:nil success:^(id json) {
        json = [json objectForKey:@"jsondata"] ;
        
        
        NSString *date = [AppUtil getNowTime];
        int dateOver = [self spare:date];
        
        NSUserDefaults *standDefus = [NSUserDefaults standardUserDefaults];
        NSString *dateEnd = [standDefus objectForKey:@"endTime"];
        int dateEndOver = [self spare:dateEnd];
        // dateEndOver = (dateOver -dateEndOver)/60 + (dateOver -dateEndOver)%60;
        dateEndOver = dateOver - dateEndOver;
        
        if(dateEndOver >600)
        {
            [self showMessageWarring:@"超时" view:app.window];
            [timer setFireDate:[NSDate distantFuture]];
             [standDefus removeObjectForKey:@"content"];
            
        }else{

            if ([[json objectForKey:@"content"] isEqualToString:@"0"]) {
                // 正在上传
                NSLog(@"上传中")
            }
            if ([[json objectForKey:@"content"] isEqualToString:@"1"]) {
                [self showMessageWarring:@"上传成功" view:app.window];
                [standDefus removeObjectForKey:@"content"];
                self.proAccuracy.progress =1.0;
                [timer setFireDate:[NSDate distantFuture]];
                
            }
            if ([[json objectForKey:@"content"] isEqualToString:@"2"]) {
                 [self showMessageWarring:@"上传失败" view:app.window];
                [timer setFireDate:[NSDate distantFuture]];
                 [standDefus removeObjectForKey:@"content"];
            }
        
        }
           } failure:^(NSError *error) {
               
        
    }];
    

    
}



#pragma mark - 滑动

- (void)leftbuttonTouch
{
    [self initRefreshView:@"1"];
    [self.dataSource removeAllObjects];
    statsIdentifi = @"1";
    _leftButton.selected = YES;
    _rightButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(70, 34, 40, 1);
    }];
    
    
}

- (void)rightButtonTouch
{
   [self initRefreshView:@"0"];
    statsIdentifi = @"0";
    [self.dataSource removeAllObjects];
    _leftButton.selected = NO;
    _rightButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _lineLabel.frame = CGRectMake(260, 34, 40, 1);
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Mark  --- collectionDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    VideoModel *model;
    if (self.dataSource.count>0) {
        model = self.dataSource[section];
    }
    NSArray *imageA = [model.filename componentsSeparatedByString:@","];
    
    return imageA.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.dataSource.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MainScreen.width/5+5, MainScreen.width/5+5);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model;
    if (self.dataSource.count>0) {
        model = self.dataSource[indexPath.section];
    }
    NSArray *imageA = [model.thumbnails componentsSeparatedByString:@","];
    
    MyVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    NSString *urlstr = @"";
    if(![AppUtil isBlankString:imageA[indexPath.row]]){
        urlstr = imageA[indexPath.row];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"sego.png"]];
    cell.imageV.backgroundColor = [UIColor blackColor];
    cell.imageV.tag = 1000*(indexPath.section+1) +indexPath.row;
    cell.imageV.userInteractionEnabled = YES;
    cell.startImageV.hidden = NO;
    cell.rightBtn.hidden = YES;
    

    UITapGestureRecognizer *tapMYP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onImageVVV:)];
    [cell.imageV addGestureRecognizer:tapMYP];
    
    return cell;
    
}

//头部
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {350,20};
    return size;
}



//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={350,20};
    return size;
}

// heder和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
        
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
   
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UILabel *label = (UILabel *)[view viewWithTag:2222];
        view.backgroundColor =[UIColor whiteColor];
        
        VideoModel *model;
        if (self.dataSource.count>0) {
            model = self.dataSource[indexPath.section];
        }

        NSArray *timeTtile =[model.opttime componentsSeparatedByString:@","];
        label.text =timeTtile[indexPath.row];
        
        
        
        
    
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UILabel *label = (UILabel *)[view viewWithTag:1111];
        view.backgroundColor =[UIColor whiteColor];
        label.backgroundColor =GRAY_COLOR;

        
    }
    return view;
    
}

// 每张图的点击
- (void)onImageVVV:(UITapGestureRecognizer *)imageSender
{
    
    if (!isSelet) {
    NSInteger i = imageSender.view.tag/1000;//分区
    int j = imageSender.view.tag%1000;//每个分区的分组
    
    VideoModel *model = self.dataSource[i-1];
    NSArray *imageA = [model.filename componentsSeparatedByString:@","];
    
    MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
    
    if (cell.rightBtn.hidden == YES) {
        cell.rightBtn.hidden = NO;
        cell.rightBtn.selected = YES;
        [deleteOrUpdateArr addObject:imageA[j]];//把要删除的图片加入删除数组
        
    }else{
        cell.rightBtn.hidden = YES;
        cell.rightBtn.selected = NO;
        [deleteOrUpdateArr removeObject:imageA[j]];//把要删除的图片从删除数组中删除
    }
    
    }else
    {
        

        // 暂时不处理事情
    }
    
}

- (int )spare:(NSString *)str
{
    int a =[[str substringWithRange:NSMakeRange(0, 2)] intValue];
    int b =[[str substringWithRange:NSMakeRange(3, 2)] intValue];
    int c=[[str substringWithRange:NSMakeRange(6, 2)] intValue];
    a= a*3600+b*60+c;
    return a;
    
}


@end
