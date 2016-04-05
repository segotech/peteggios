//
//  AccountManager.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AccountManager.h"
#import "NSUserDefaults+RMSaveCustomObject.h"

#define KEY_LOGIN_INFO     @"LoginInfo"

@implementation AccountManager

singleton_implementation(AccountManager)

- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

/**
 *  登录
 */
-(void)login{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
}

/**
 *  登出
 */
-(void)logout{
    
}

/**
 *  是否登录
 */
-(BOOL)isLogin{
    
    return NO;
}

@end
