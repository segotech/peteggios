//
//  TransaceTableViewCell.m
//  petegg
//
//  Created by czx on 16/5/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "TransaceTableViewCell.h"

@implementation TransaceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _runAccoun = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 5 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _runAccoun.textColor = [UIColor blackColor];
        _runAccoun.text = @"消费";
        _runAccoun.font = [UIFont systemFontOfSize:13];
        [self addSubview:_runAccoun];
        
        
        _balance = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 37 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _balance.text = @"来源:";
        _balance.textColor = [UIColor grayColor];
        _balance.font = [UIFont systemFontOfSize:11];
        [self addSubview:_balance];
        
        
        _money = [[UILabel alloc]initWithFrame:CGRectMake(45 * W_Wide_Zoom, 37 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _money.text = @"30";
        _money.textColor = [UIColor grayColor];
        _money.font = [UIFont systemFontOfSize:11];
        [self addSubview:_money];
        
        _runAccounNumber  = [[UILabel alloc]initWithFrame:CGRectMake(285 * W_Wide_Zoom, 10 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _runAccounNumber.text = @"+50";
        _runAccounNumber.textColor = [UIColor greenColor];
        _runAccounNumber.font = [UIFont systemFontOfSize:11];
        [self addSubview:_runAccounNumber];
        
        
        _data = [[UILabel alloc]initWithFrame:CGRectMake(200 * W_Wide_Zoom, 37 * W_Hight_Zoom, 120 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _data.text = @"2015-10-09 16:48";
        _data.textColor = [UIColor grayColor];
        _data.font = [UIFont systemFontOfSize:10];
        [self addSubview:_data];

    }

    return self;
}

@end
