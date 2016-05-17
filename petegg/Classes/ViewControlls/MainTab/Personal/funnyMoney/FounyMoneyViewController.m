//
//  FounyMoneyViewController.m
//  petegg
//
//  Created by yulei on 16/4/26.
//  Copyright © 2016年 sego. All rights reserved.
//

#define ProductID_IAP0p18 @"com.sego.eggpet.1"//18
#define ProductID_IAP0p25 @"com.sego.eggpet.2"//10
#define ProductID_IAP0p30 @"com.sego.eggpet.3"//10
#define ProductID_IAP0p40 @"com.sego.eggpet.4"//10
#define ProductID_IAP0p50 @"com.sego.eggpet.5"//10
#define ProductID_IAP0p60 @"com.sego.eggpet.6"//10
#define ProductID_IAP0p73 @"com.sego.eggpet.7"//10
#define ProductID_IAP0p88 @"com.sego.eggpet.8"//10
#define ProductID_IAP0p93 @"com.sego.eggpet.9"//10



#import "FounyMoneyViewController.h"
#import "TransactiondetailViewController.h"

@interface FounyMoneyViewController ()
{
    
    // 物品信息
    NSArray *subjects;
    NSArray *body;
    
    // 内购
    NSString * productNum;
    NSMutableArray * dataSoureArr;
    
   // preice
    NSString * preiceNum;
    
    
    
}

@end

@implementation FounyMoneyViewController
@synthesize overLB;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"remain", nil)];
    
}


-(void)setupView
{
    [super setupView];
    //[self showBarButton:NAV_RIGHT imageName:@"doumashare.png"];
    
    [self showBarButton:NAV_RIGHT  title:@"明细" fontColor:[UIColor blackColor]];
    dataSoureArr =[NSMutableArray array];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

}


// 明细
- (void)doRightButtonTouch
{
    TransactiondetailViewController * transacVc = [[TransactiondetailViewController alloc]init];
    [self.navigationController pushViewController:transacVc animated:YES];
    
    
}

- (void)setupData
{
    [super setupData];
    
    // 标题
    subjects = @[@"充值10元100逗币",
                 @"充值20元200逗币",@"充值30元300逗币",@"充值50元500逗币",
                 @"充值100元1000逗币",@"充值200元2000逗币",@"充值300元3000逗币",
                 @"充值500元5000逗币",@"充值1000元10000逗币"];
    // 描述
    body = @[@"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",
             @"买逗币",];
    
    //  查询余额
    [self requestRemainMoney];
    
}



- (void)requestRemainMoney

{
    
    
    NSString * str = @"clientAction.do?method=json&common=getFinance&classes=appinterface";
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        dataSoureArr = json[@"jsondata"][@"list"];
        overLB.text = dataSoureArr[0][@"over"];
        
        
        
        NSLog(@"%@",json); 
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)buy:(NSString *)sender
{
    productNum = sender;
    NSString *product = sender;
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:product];
    }else{
        NSLog(@"不允许程序内付费");
    }
    
}




#pragma mark  payDeledate

//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil,nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
    
}


//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:productNum]){
            p = pro;
        }
    }
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------%@",request);
}


//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                
                [self RechargeSucces];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                
                break;
            default:
                break;
        }
    }
}

/**
 * button 点击
 */

// 1
- (IBAction)oneBtn:(id)sender {
    
    [self buy:ProductID_IAP0p18];
    preiceNum = @"18";
    

}

// 2
- (IBAction)twoBtn:(id)sender {
     [self buy:ProductID_IAP0p25];
    preiceNum = @"25";
    
}
//3
- (IBAction)threeBtn:(id)sender {
    
    [self buy:ProductID_IAP0p30];
    preiceNum = @"30";
}
//4
- (IBAction)fourBtn:(id)sender {
     [self buy:ProductID_IAP0p40];
    preiceNum = @"40";
    
}

// 5
- (IBAction)fiveBtn:(id)sender {
    
     [self buy:ProductID_IAP0p50];
    preiceNum = @"50";
}

// 6
- (IBAction)sixBTN:(id)sender {
    [self buy:ProductID_IAP0p60];
    preiceNum = @"60";
}

// 7
- (IBAction)servenBtn:(id)sender {
     [self buy:ProductID_IAP0p73];
    preiceNum = @"73";
    
}

// 8
- (IBAction)eightBtn:(id)sender {
    [self buy:ProductID_IAP0p88];
    preiceNum = @"88";

}
// 9
- (IBAction)nineBtn:(id)sender {
    [self buy:ProductID_IAP0p93];
    preiceNum =@"93";
    
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)RechargeSucces
{
    
    NSString * str = @"clientAction.do?method=json&common=recharge&classes=appinterface";
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [dic setValue:preiceNum forKey:@"money"];

    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


@end
