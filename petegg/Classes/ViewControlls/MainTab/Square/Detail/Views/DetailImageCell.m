//
//  DetailImageCell.m
//  petegg
//
//  Created by ldp on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailImageCell.h"

#import "UIImageView+WebCache.h"

@interface DetailImageCell()

@property (nonatomic, strong) UIImageView *iconIV;

@end

@implementation DetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupView{
    
    _iconIV = [UIImageView new];
    _iconIV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView sd_addSubviews:@[_iconIV]];
    
    _iconIV.sd_layout.topSpaceToView(self.contentView,8).leftSpaceToView(self.contentView, 8).rightSpaceToView(self.contentView, 8).heightIs(30);
}

- (void)setModel:(NSString *)model{
    
    _model = model;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image && self.iconIV.width > 0) {
            
            CGSize size = image.size;
            
            if (size.width >= self.width) {
                
                if (size.width < size.height) {
                    self.iconIV.sd_layout.heightIs(size.height / (size.width / self.iconIV.width));
                }else{
                    self.iconIV.sd_layout.heightIs(self.iconIV.width * size.height / size.width);
                }
                
            }else{
                self.iconIV.sd_layout.heightIs(size.height);
            }
        }
    }];
    
    [self setupAutoHeightWithBottomView:self.iconIV bottomMargin:8];
}

@end
