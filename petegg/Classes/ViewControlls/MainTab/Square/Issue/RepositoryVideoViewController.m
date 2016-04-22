//
//  RepositoryVideoViewController.m
//  petegg
//
//  Created by czx on 16/4/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RepositoryVideoViewController.h"
#import "AFHttpClient+Issue.h"
@interface RepositoryVideoViewController ()

@end

@implementation RepositoryVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupView{
    [super setupView];
    self.str = @"youzhi";
    
    
    
}
-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]getVideoWithMid:@"MI16010000004292" complete:^(BaseModel *model) {
        
    }];

}





@end
