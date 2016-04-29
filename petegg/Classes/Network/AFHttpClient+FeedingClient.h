//
//  AFHttpClient+FeedingClient.h
//  petegg
//
//  Created by czx on 16/4/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (FeedingClient)


//查询喂食设置
-(void)queryFeedingtimeWithMid:(NSString *)mid
                           complete:(void(^)(BaseModel *model))completeBlock;

//添加喂食
-(void)addFeedingtimeWithMid:(NSString *)mid
                         type:(NSString *)type
                         times:(NSString *)times
                         complete:(void(^)(BaseModel *model))completeBlock;




@end
