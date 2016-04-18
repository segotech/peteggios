//
//  PersonAttentionTableViewCell.m
//  petegg
//
//  Created by czx on 16/4/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonAttentionTableViewCell.h"

@implementation PersonAttentionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 60 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = GRAY_COLOR;
        [self addSubview:_lineLabel];
        
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 40 * W_Wide_Zoom, 40 * W_Wide_Zoom)];
        [_headImage.layer setMasksToBounds:YES];
        _headImage.layer.cornerRadius = _headImage.width/2;
        _headImage.backgroundColor = [UIColor redColor];
        [self addSubview:_headImage];
        
        
    }

    return self;
}
@end
