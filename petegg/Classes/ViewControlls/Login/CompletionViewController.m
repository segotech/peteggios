//
//  CompletionViewController.m
//  petegg
//
//  Created by yulei on 16/4/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CompletionViewController.h"


@interface CompletionViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    NSString * girlOrBoy;
    NSString * catOrDog;
    NSUInteger sourceType;
    
    
    
}

@end

@implementation CompletionViewController

@synthesize handImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor whiteColor];
     [self setNavTitle: NSLocalizedString(@"completion", nil)];
    handImage.userInteractionEnabled = YES;
    
    
}


- (void)setupView{
    [super setupView];
    
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
    [handImage addGestureRecognizer:singleRecognizer];
    
  
    
    
}

/**
 *  头像点击
 */
- (void)handleSingleTapFrom:(UITapGestureRecognizer *)tap
{
    
    UIAlertController *sheet;
    //判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        sheet = [UIAlertController alertControllerWithTitle:@"选择上传方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 普通按键
         
            sourceType = UIImagePickerControllerSourceTypeCamera;
            [self openXC];
            
            
        }];
        UIAlertAction *laterAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 普通按键
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self openXC];
            
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 取消按键
        }];
        
        
        [sheet addAction:laterAction];
        [sheet addAction:laterAction1];
        [sheet addAction:okAction];
        [self presentViewController:sheet animated:YES completion:nil];

        
    }
    
}


- (void)openXC
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

//UIImagePickerController的代理函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [handImage setImage:image];
    
    //获得头像之后将头像上传
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    [self submitAvatarImage:imageData];
    
}

//上传头像
- (void)submitAvatarImage:(NSData *)imageData
{
  //base64EncodedStringWithOptions:0
    NSString *base64str = [imageData base64EncodedStringWithOptions:0];
    NSString *picstr = [NSString stringWithFormat:@"[{\"%@\":\"%@\",\"%@\":\"%@\"}]",@"name",@"avatar.jpg",@"content",base64str];
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
    [dicc setValue:self.mid forKey:@"mid"];
    [dicc setValue:picstr forKey:@"picture"];
    NSString * str = @"clientAction.do?common=modifyHeadportrait&classes=appinterface&method=json";
    [AFNetWorking postWithApi:str parameters:dicc success:^(id json) {
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)setupData
{
    [super setupData];
    
    
}

/**
 *  XLB 点击事件
 */
- (IBAction)brithdayBtn:(UIButton *)sender {
    
    self.backView.hidden = NO;
    
}

- (IBAction)manBtn:(UIButton *)sender {
   
    [self chooseOnebtn:2004 button:sender];
    
    
}

- (IBAction)wowenSelect:(UIButton *)sender {
    
    [self chooseOnebtn:2003 button:sender];

}

- (IBAction)dogWindowsBtn:(UIButton *)sender {
   [self chooseOnebtn:2006 button:sender];
    
    
}


- (IBAction)catWindowsBtn:(UIButton *)sender {
   [self chooseOnebtn:2005 button:sender];
    
}

- (IBAction)dateTimePicker:(UIDatePicker *)sender {
    
    /*
    NSDate*selected = [self.timeSelect date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *destDateString = [dateFormatter stringFromDate:selected];
     NSString *message =  [NSString stringWithFormat: @"您选择的日期和时间是：%@",
                 destDateString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"日期和时间" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
          [alert show];
     */
    
     
    
    
}

- (IBAction)overViewBtn:(UIButton *)sender {
    
    self.backView.hidden = YES;
    NSDate*selected = [self.timeSelect date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.birthdayBtn.titleLabel.text = [NSString stringWithFormat:@"%@",destDateString];
    
}

// 点击完成
- (IBAction)overBtn:(UIButton *)sender {
    
    
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=writeData";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:self.nameTextF.text forKey:@"nickname"];
    [dic setValue:self.birthdayBtn.titleLabel.text forKey:@"pet_birthday"];
    [dic setValue:catOrDog forKey:@"pet_race"];
    [dic setValue:girlOrBoy forKey:@"pet_sex"];
    [dic setValue:self.mid forKey:@"mid"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        if ([json[@"jsondata"][@"retCode"] isEqualToString:@"0000"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
        
    } failure:^(NSError *error) {
    }];

    
}


- (void)chooseOnebtn:(NSInteger )tag button:(UIButton *)sender
{
    
    switch (tag) {
        case 2004:
            
            girlOrBoy = @"公";
            break;
        case 2003:
            
            girlOrBoy = @"母";
            break;
            
        case 2005:
            
            catOrDog= @"喵";
            break;
            
        case 2006:
            
            
            catOrDog = @"汪";
            break;
            
            
        default:
            break;
    }
    
    UIButton * btn =(UIButton *)[self.view viewWithTag:tag];
    if (!btn.selected) {
        sender.selected =!sender.selected;
    }
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
