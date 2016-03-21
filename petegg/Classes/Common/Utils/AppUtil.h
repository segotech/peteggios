//
//  AppUtil.h
//  petegg
//
//  存放公用方法
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <Foundation/Foundation.h>

//蓝色
#define GREEN_COLOR RGB(73, 195, 241)

//灰色
#define GRAY_COLOR RGB(205, 205, 193)

#undef	NAV_BUTTON_MIN_WIDTH
#define	NAV_BUTTON_MIN_WIDTH	(40.0f)

#undef	NAV_BUTTON_MIN_HEIGHT
#define	NAV_BUTTON_MIN_HEIGHT	(40.0f)

#undef	NAV_BAR_HEIGHT
#define	NAV_BAR_HEIGHT	(44.0f)

#define WHITE_FG [UIColor colorWithPatternImage:[UIImage imageNamed:@"white_fg"]]
// 适配代码部分
#define M_Wide 375
#define M_Higth 667

// 缩放比例
#define W_Wide_Zoom [UIScreen mainScreen].bounds.size.width/M_Wide
#define W_Hight_Zoom [UIScreen mainScreen].bounds.size.height/M_Higth
// 海之蓝
#define AllBackColor [UIColor colorWithRed:73/255.0 green:195/255.0 blue:241/255.0 alpha:1]



@interface AppUtil : NSObject
// 服务器
+ (NSString *)getServerSego3;
+ (NSString*) getServer;
// 字符判断
+ (BOOL) isBlankString:(NSString *)string;
// 单个颜色grb
+ (CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
// 判断手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;
// lable 适应
+ (CGSize)lable:(UILabel *)sender scaleToSize:(CGSize)sizeL;
// 图片处理
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;


@end
