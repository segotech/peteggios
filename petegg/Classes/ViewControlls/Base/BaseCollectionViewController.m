//
//  BaseCollectionViewController.m
//  petegg
//
//  Created by yulei on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super  viewWillAppear:animated];
    
}

- (void)setupView
{
    [super setupView];
    UICollectionViewFlowLayout * fl=[[UICollectionViewFlowLayout alloc] init];
    fl.scrollDirection=UICollectionViewScrollDirectionVertical;
    _collection =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:fl]
    ;
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_collection];
    
}

- (void)setupData

{
    [super setupData];
    _dataSource =[[NSMutableArray alloc]init];

}



- (void)updateData
{
    
    [self.collection.header beginRefreshing];
    
}


- (void)initRefreshView
{
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
      
    }];
    
    self.collection.footer.hidden = YES;
    [self.collection.header beginRefreshing];
}

-(void)handleEndRefresh{
    
    [self.collection.header endRefreshing];
}

#pragma Mrak ---UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
    
}



@end
