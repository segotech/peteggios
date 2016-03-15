//
//  AccountManager.h
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

singleton_interface(AccountManager)

/**
 *  登录
 */
-(void)login;

/**
 *  登出
 */
-(void)logout;


@end
