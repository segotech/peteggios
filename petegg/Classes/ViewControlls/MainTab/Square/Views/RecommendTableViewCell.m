//
//  RecommendTableViewCell.m
//  petegg
//
//  Created by czx on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        
        self.lineLable =[[UILabel alloc]initWithFrame:CGRectMake(0, 369 * W_Hight_Zoom , 375 * W_Wide_Zoom, 1)];
        self.lineLable.backgroundColor =GRAY_COLOR;
        
        [self addSubview:self.lineLable];
        
        
        // 头像
        self.iconImageV =[[UIImageView alloc]initWithFrame:CGRectMake(8*W_Wide_Zoom, 12*W_Hight_Zoom, 50*W_Wide_Zoom, 50*W_Hight_Zoom)];
        [self addSubview:self.iconImageV];
        
        // 名字
        
        self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*W_Wide_Zoom, 30*W_Hight_Zoom, 100*W_Wide_Zoom, 20)];
        self.nameLabel.font =[UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];
        
        self.introduceLable =[[UILabel alloc]initWithFrame:CGRectMake(8*W_Wide_Zoom, 320*W_Hight_Zoom, 300*W_Wide_Zoom, 20*W_Hight_Zoom)];
        self.introduceLable.font =[UIFont systemFontOfSize:13];
        self.introduceLable.textColor =[UIColor grayColor];
        [self addSubview:self.introduceLable];
        
        self.photoView =[[UIImageView alloc]initWithFrame:CGRectMake(0*W_Wide_Zoom, 65*W_Hight_Zoom, 375*W_Wide_Zoom, 250*W_Hight_Zoom)];
        self.photoView.backgroundColor =[UIColor clearColor];
        [self addSubview:self.photoView];
    
        // 图片张数
        self.numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(310*W_Wide_Zoom, self.photoView.bounds.size.height-40*W_Hight_Zoom, 40*W_Wide_Zoom, 30*W_Hight_Zoom)];
        //self.numberLabel.backgroundColor =[UIColor colorWithRed:20/255.0 green:32/255.0 blue:40/255.0 alpha:0.6];
        [self.photoView addSubview:self.numberLabel];
        
        // 时间
        self.timeLable =[[UILabel alloc]initWithFrame:CGRectMake(8*W_Wide_Zoom, 345*W_Hight_Zoom, 200*W_Wide_Zoom, 30*W_Hight_Zoom)];
        self.timeLable.font =[UIFont systemFontOfSize:10];
        self.timeLable.textColor =[UIColor grayColor];
        [self addSubview:self.timeLable];
        // 评论  图标
        
        self.pinglun =[[UIImageView alloc]initWithFrame:CGRectMake(290*W_Wide_Zoom, 345*W_Hight_Zoom, 12*W_Wide_Zoom, 12*W_Hight_Zoom)];
        self.pinglun.image = [UIImage imageNamed:@"评论.png"];
        [self addSubview:self.pinglun];
        
        self.leftnumber =[[UILabel alloc]initWithFrame:CGRectMake(310*W_Wide_Zoom, 335*W_Hight_Zoom, 30*W_Wide_Zoom, 30*W_Hight_Zoom)];
        self.leftnumber.font =[UIFont systemFontOfSize:10];
        self.leftnumber.textColor =[UIColor grayColor];
        [self addSubview:self.leftnumber];
        
        // 点赞
        
        self.aixin =[[UIImageView alloc]init];
        
        self.aixin.frame =CGRectMake(330*W_Wide_Zoom, 345*W_Wide_Zoom, 12*W_Wide_Zoom, 12*W_Hight_Zoom);
        self.aixin.image =[UIImage imageNamed:@"点赞5.png"];
        [self addSubview:self.aixin];
        
        
        self.rihttnumber =[[UILabel alloc]initWithFrame:CGRectMake(346*W_Wide_Zoom, 335*W_Hight_Zoom, 60*W_Wide_Zoom,30*W_Hight_Zoom)];
        self.rihttnumber.font =[UIFont systemFontOfSize:10];
        self.rihttnumber.textColor =[UIColor grayColor];
        [self addSubview:self.rihttnumber];
        
        self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(158*W_Wide_Zoom, 180 * W_Hight_Zoom, 50 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
        [self.centerImage setImage:[UIImage imageNamed:@"MV.png"]];
        // [self addSubview:self.centerImage];
    
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 373 * W_Wide_Zoom, 10 * W_Hight_Zoom)];
        self.topView.backgroundColor = [UIColor lightGrayColor];
        self.topView.alpha = 0.1;
        [self addSubview:self.topView];
        
        self.aboutBtn = [[UIButton alloc]initWithFrame:CGRectMake(305 * W_Wide_Zoom, 23 * W_Hight_Zoom, 60 * W_Wide_Zoom, 25 * W_Hight_Zoom)];
        self.aboutBtn.backgroundColor = GREEN_COLOR;
        self.aboutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.aboutBtn setTitle:@"+关注" forState:UIControlStateNormal];
//        [self.aboutBtn setTitle:@"已关注" forState:UIControlStateSelected];
        self.aboutBtn.layer.cornerRadius = 5;
        [self.aboutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.aboutBtn];
        
//        self.cancelAboutButton = [[UIButton alloc]initWithFrame:CGRectMake(305 * W_Wide_Zoom, 23 * W_Hight_Zoom, 60 * W_Wide_Zoom, 25 * W_Hight_Zoom)];
//        self.cancelAboutButton.backgroundColor = GREEN_COLOR;
//        self.cancelAboutButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.cancelAboutButton setTitle:@"已关注" forState:UIControlStateNormal];
//        self.cancelAboutButton.layer.cornerRadius = 5;
//        [self.cancelAboutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self addSubview:self.cancelAboutButton];
        
        
        
        
    }

    return self;
}
@end
