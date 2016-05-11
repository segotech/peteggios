//
//  FounyMoneyViewController.h
//  petegg
//
//  Created by yulei on 16/4/26.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"
#import <StoreKit/StoreKit.h>

@interface FounyMoneyViewController : BaseViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (strong, nonatomic) IBOutlet UILabel *overLB;
@end
