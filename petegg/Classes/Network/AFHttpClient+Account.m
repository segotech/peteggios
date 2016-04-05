//
//  AFHttpClient+Account.m
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Account.h"

@implementation AFHttpClient (Account)

- (void)loginWithUserName:(NSString*)userName password:(NSString*)password complete:(void(^)(BaseModel *model))completeBlock failure:(void(^)())failureBlock{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    params[@"common"] = @"memberLogin";
    
    params[@"accountnumber"] = userName;
    params[@"password"] = password;
    
    params[@"model"] = [[UIDevice currentDevice] model];
    params[@"brand"] = @"iphone";
    params[@"version"] = [[UIDevice currentDevice] systemVersion];
    params[@"imei"] = @"";
    params[@"imsi"] = @"";
    params[@"type"] = @"ios";
    
    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            
            BaseModel* model = [[BaseModel alloc] initWithDictionary:responseObject[@"jsondata"] error:nil];
            model.list = [LoginModel arrayOfModelsFromDictionaries:model.list];
            
            completeBlock(model);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];
}

@end
