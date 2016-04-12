//
//  AFHttpClient.h
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "SquareModel.h"
#import "LoginModel.h"
#import "DetailModel.h"
#import "CommentModel.h"
#import "PersonDetailModel.h"
#import "NearbyModel.h"

#define BASE_URL    @"clientAction.do?common=queryFollowSproutpet&classes=appinterface&method=json"



@interface AFHttpClient : AFHTTPRequestOperationManager

singleton_interface(AFHttpClient)

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters result:(void (^)(BaseModel* model))result;

@end
