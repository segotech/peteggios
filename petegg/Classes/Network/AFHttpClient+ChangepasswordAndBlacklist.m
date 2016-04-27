//
//  AFHttpClient+ChangepasswordAndBlacklist.m
//  petegg
//
//  Created by czx on 16/4/26.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+ChangepasswordAndBlacklist.h"

@implementation AFHttpClient (ChangepasswordAndBlacklist)
-(void)modifyPasswordWithMid:(NSString *)mid password:(NSString *)password complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] = @"modifyPassword";
    params[@"mid"] = mid;
    params[@"password"]=  password;
    
    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
            // model.list = [InformationModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];
    
    
    

}

-(void)addBlacklistWithMid:(NSString *)mid friend:(NSString *)friendId complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] = @"addBlacklist";
    params[@"mid"] = mid;
    params[@"friend"] = friendId;
    
    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
            // model.list = [InformationModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];

}

-(void)queryBlacklistWithMid:(NSString *)mid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] =@"queryBlacklist";
    params[@"mid"] = mid;
    
    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
             model.list = [BlackListModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];

}

-(void)delBlacklistWithMid:(NSString *)mid friend:(NSString *)friendId complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] = @"delBlacklist";
    params[@"mid"] = mid;
    params[@"friend"] = friendId;
    
    
    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
            // model.list = [InformationModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];
    

}




@end
