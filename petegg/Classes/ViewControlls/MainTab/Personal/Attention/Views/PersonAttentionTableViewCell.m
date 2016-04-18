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
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 59 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = GRAY_COLOR;
        [self addSubview:_lineLabel];
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 40 * W_Wide_Zoom, 40 * W_Wide_Zoom)];
        [_headImage.layer setMasksToBounds:YES];
        _headImage.layer.cornerRadius = _headImage.width/2;
        _headImage.backgroundColor = [UIColor redColor];
        [self addSubview:_headImage];
        
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 * W_Wide_Zoom,  12 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"呵呵da";
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
        
        
        _kindImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 14 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        [_kindImage.layer setMasksToBounds:YES];
       // _kindImage.image = [UIImage imageNamed:@"miao.png"];
        _kindImage.layer.cornerRadius = _kindImage.width/2;
        [self addSubview:_kindImage];
        
        
        
        _sinaglLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 * W_Wide_Zoom, 30 * W_Hight_Zoom, 200 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _sinaglLabel.font = [UIFont systemFontOfSize:12];
        _sinaglLabel.textColor = [UIColor blackColor];
        //_sinaglLabel.text = @"陈大侠是个大帅比";
        [self addSubview:_sinaglLabel];
        
        
        
        
        
        
        
        
        
    }

    return self;
}
@end
