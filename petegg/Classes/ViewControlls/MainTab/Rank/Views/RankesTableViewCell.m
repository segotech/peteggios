//
//  RankesTableViewCell.m
//  petegg
//
//  Created by czx on 16/4/13.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RankesTableViewCell.h"

@implementation RankesTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Wide_Zoom, 375 * W_Wide_Zoom, 60 * W_Wide_Zoom)];
        _backView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_backView];
        
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 60 * W_Hight_Zoom, 355 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_lineLabel];
        
    }


    return self;

}


@end
