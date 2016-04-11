//
//  NearTableViewCell.m
//  petegg
//
//  Created by czx on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NearTableViewCell.h"

@implementation NearTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
        _lineLabel.alpha = 0.2;
        [self addSubview:_lineLabel];
        
        
        _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 40 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        _headBtn.layer.cornerRadius = _headBtn.width/2;
        _headBtn.backgroundColor = [UIColor blackColor];
        [self addSubview:_headBtn];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55 * W_Wide_Zoom, 10 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"贝贝";
        [self addSubview:_nameLabel];
        
        _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(55 * W_Wide_Zoom, 30 * W_Hight_Zoom, 200 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _signLabel.textColor = [UIColor blackColor];
        _signLabel.font = [UIFont systemFontOfSize:11];
        _signLabel.text = @"我是一个大帅比";
        [self addSubview:_signLabel];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 15 * W_Hight_Zoom, 50 * W_Wide_Zoom, 25 * W_Hight_Zoom)];
        _rightBtn.backgroundColor = GREEN_COLOR;
        [self addSubview:_rightBtn];
    
    
    }
    return self;
}

@end
