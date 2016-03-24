//
//  AFHttpClient.m
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"



@implementation AFHttpClient

singleton_implementation(AFHttpClient)

- (instancetype)init{
    if (self = [super initWithBaseURL:[NSURL URLWithString: [AppUtil getServerSego3]]]) {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json", nil];
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    
                    break;
                default:
                    break;
            }
        }];
        [self.reachabilityManager startMonitoring];
    }
    
    return self;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation * _Nonnull, id _Nonnull))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError * _Nonnull))failure{
    
    return [super POST:URLString parameters:parameters success:success failure:failure];
}

@end
