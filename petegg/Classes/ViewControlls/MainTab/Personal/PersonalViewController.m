//
//  PersonalViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "PersonalViewController.h"
#import "personTableViewCell.h"
#import <Accelerate/Accelerate.h>

@interface PersonalViewController()

{
    UIButton * _heandBtn;
    UILabel *  _nameLabel;
    
    
    
    
}

@end

@implementation PersonalViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"tabPersonal", nil)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
// 补改xlb
- (void)viewDidLayoutSubviews
{
    
}

- (void)setupView
{
    [super setupView];
    
    UIView  * _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    _headView.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,375,200)];
    bgImgView.image = [self blurryImage:[self cutImage:[UIImage imageNamed:@"ceishi.jpg"]] withBlurLevel:0.2];
    [_headView addSubview:bgImgView];
    [_headView sendSubviewToBack:bgImgView];
    
 
    
    [self.view addSubview:_headView];
    
    // 头像
    _heandBtn =[[UIButton alloc]initWithFrame:CGRectMake(_headView.center.x-40, self.view.origin.y+30, 80, 80)];
    [_heandBtn setImage:[UIImage imageNamed:@"ceishi.jpg"] forState:UIControlStateNormal];
    [_heandBtn.layer setMasksToBounds:YES];
    [_heandBtn.layer setCornerRadius:40]; //设置矩形四个圆角半径
    _heandBtn.userInteractionEnabled = YES;
    [_heandBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:_heandBtn];
    
    /**
        点赞  名字
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    _nameLabel.text = @"我是余磊 我爱打麻将";
    _nameLabel.center = CGPointMake(self.view.center.x,_heandBtn.frame.origin.y+160);
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_nameLabel];

    
 
  

   /**
    *  循环控件 3个12
    *
    */
    
    
    
    
    
   
    self.tableView.frame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    
    self.tableView.tableHeaderView =_headView;
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
   
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    [self showBarButton:NAV_RIGHT imageName:@"new_3point.png"];
     NSArray * arrName =@[@"动态",@"录像",@"抓拍",@"关注",@"黑名单",@"逗币",@"逗码",@"权限设置",@"修改密码"];
    [self.dataSource addObjectsFromArray:arrName];
    NSArray * arrImage =@[@"person_videotape.png",@"person_photograph.png",@"person_balance.png",@"person_attention.png",@"blank_list.png",@"person_balance.png",@"person_code.png",@"person_rule.png",@"person_balance.png"];
    [self.dataSourceImage addObjectsFromArray:arrImage];
    
    
    

    
    
}
// 头像点击
- (void)headBtnClick:(UIButton *)sender
{
    
    
    
}


// 关于sego
- (void)doRightButtonTouch
{
    
    NSLog(@"1233");
    
    
}


#pragma Marr ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    switch (section) {
            
        case 0:
            
            return  3;
            
            break;
            
        case 1:
            
            return  4;
            
            break;
            
        case 2:
            return 2;
            break;
        default:
            
            return 0;
            
            break;
            
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width+3, 18)];
    [sectionView setBackgroundColor:[UIColor clearColor]];
    sectionView.layer.borderWidth =0.4;
    sectionView.layer.borderColor =GRAY_COLOR.CGColor;
    return sectionView;
}


//  设置标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  0.5;
            
            break;
            
        case 1:
            
            return  18;
            
            break;
            
        case 2:
            return 18;
            break;
        default:
            
            return 0;
            
            break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell123";
    personTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        cell = [[personTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showUserInfoCellIdentifier];
    }
    
    switch (indexPath.section) {
            
        case 0:
            // Configure the cell.
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row];
            break;
            
        case 1:
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row+3]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row+3];

            break;
            
        case 2:
            cell.imageCell.image =[UIImage imageNamed:self.dataSourceImage[indexPath.row+7]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.introduce.text= self.dataSource[indexPath.row+7];
            break;
            
        default:
            
            break;
            
    }
    
    // 选择之后的风格
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.section) {
        case 0:
            
            if (indexPath.row == 0) {
                NSLog(@"时光轴");
            
            }
            if (indexPath.row == 1) {
                NSLog(@"录像");
                
               
                
            }
            if (indexPath.row == 2) {
                NSLog(@"抓拍");
            
                
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                
                NSLog(@"00");
               
                
            }
            if (indexPath.row == 1) {
              
            }
            
            if (indexPath.row == 2) {
                NSLog(@"11");
               
                
            }
            
            if (indexPath.row == 3) {
               
                
            }
            break;
            
        case 2:
            if (indexPath.row ==0) {
                NSLog(@"000");
                
            
                
            }
            
            
            if (indexPath.row  ==1) {
                NSLog(@"111");
                
                
            }
            
            
            break;
        default:
            break;
    }
    
    
}
/**
 *  @1毛玻璃效果方法
 *
 *  @param radius
 *  @param image
 *
 *  @return 
 */
+ (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image
{
    if (radius < 0) radius = 0;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    // Setting up gaussian blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}


/**
 *
 *  @2 第二种方法
 *  @param image
 *  @param blur  模糊度
 *
 *  @return image
 */
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    //    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 *  处理图片
 */

- (UIImage *)cutImage:(UIImage*)image
{
    
    CGSize newSize;
    CGImageRef imageRef = nil;
    UIImageView *_headerView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    
    
    if ((image.size.width / image.size.height) < (_headerView.bounds.size.width / _headerView.bounds.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _headerView.bounds.size.height / _headerView.bounds.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _headerView.bounds.size.width / _headerView.bounds.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage * newnewimage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newnewimage;
    //return [UIImage imageWithCGImage:imageRef];
}

@end
