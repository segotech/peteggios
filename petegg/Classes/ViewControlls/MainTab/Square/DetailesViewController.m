//
//  DetailesViewController.m
//  petegg
//
//  Created by czx on 16/4/8.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailesViewController.h"
#import "AFHttpClient+Detailed.h"

@interface DetailesViewController ()

@end

@implementation DetailesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]queryCommentWithWid:_stid pageIndex:1 pageSize:10 complete:^(BaseModel *model) {
        
    } failure:^{
        
    }];
}

@end
