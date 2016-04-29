//
//  AFHttpClient+FeedingClient.m
//  petegg
//
//  Created by czx on 16/4/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+FeedingClient.h"

@implementation AFHttpClient (FeedingClient)

-(void)queryFeedingtimeWithMid:(NSString *)mid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] = @"queryFeedingtime";
    params[@"mid"] = mid;

    
    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
              model.list = [FeddingModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];

}


-(void)addFeedingtimeWithMid:(NSString *)mid type:(NSString *)type times:(NSString *)times complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"common"] = @"addFeedingtime";
    params[@"mid"] = mid;
    params[@"type"] = type;
    params[@"times"] = times;
    
    
    
    
    
    


}




@end
