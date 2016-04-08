//
//  AFHttpClient+Detailed.m
//  petegg
//
//  Created by czx on 16/4/8.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Detailed.h"

@implementation AFHttpClient (Detailed)


-(void)querDetailWithStid:(NSString *)stid complete:(void (^)(BaseModel *))completeBlock failure:(void (^)())failureBlock{
     NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"common"] = @"queryByStid";
    params[@"stid"] = stid;

    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            
            BaseModel* model = [[BaseModel alloc] initWithDictionary:responseObject[@"jsondata"] error:nil];
            model.list = [DetailModel arrayOfModelsFromDictionaries:model.list];
            
            
            completeBlock(model);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];
}


-(void)queryCommentWithWid:(NSString *)wid pageIndex:(int)pageIndex pageSize:(int)pageSize complete:(void (^)(BaseModel *))completeBlock failure:(void (^)())failureBlock{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"common"] = @"querycomment";
    params[@"ptype"] = @"m";
    params[@"wid"] = wid;
    params[@"page"] = @(pageIndex);
    params[@"size"] = @(pageSize);
    
    /*
     wid:文章标识 （就是传过来的stid）
     size  page
     */
    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            
            BaseModel* model = [[BaseModel alloc] initWithDictionary:responseObject[@"jsondata"] error:nil];
         
            //这里接口已经调通了，model不知道该怎么写了，list里面还有数组，我蒙b了
            //  model.list = [DetailModel arrayOfModelsFromDictionaries:model.list];

            completeBlock(model);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];

    
    
}


-(void)AddCommentWithPid:(NSString *)pid bid:(NSString *)bid wid:(NSString *)wid bcid:(NSString *)bcid ptype:(NSString *)ptype action:(NSString *)action content:(NSString *)content  complete:(void (^)(BaseModel *))completeBlock failure:(void (^)())failureBlock{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"common"] = @"addComment";
    params[@"pid"] = pid; //这里传自己的mid
    params[@"bid"] = bid;  //如果评论的是文章就传空，如果是回复评论人，就传被评论人的mid（这个mid在上面的接口里面拿得到）
    params[@"wid"] = wid;//如果评论的是文章就传stid，如果是回复评论人，就不传
    params[@"bcid"] = bcid;//被评论人的mid，也是在上一个街口能拿到
    params[@"ptype"] = ptype;//评论文章传m，回复人传r
    params[@"action"]  = action;//评论动作类型，文章，p。人，h。
    params[@"content"] = content;//回复内容
    params[@"type"] = @"m";
    
    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            
         //这里只需要 返回的retCode = 0000;就行了
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];
    
}














@end
