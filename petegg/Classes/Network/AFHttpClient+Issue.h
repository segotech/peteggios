//
//  AFHttpClient+Issue.h
//  petegg
//
//  Created by czx on 16/4/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Issue)
-(void)addSproutpetWithMid:(NSString *)mid content:(NSString *)content type:(NSString *)type resources:(NSMutableString *)resources  complete:(void(^)(BaseModel *model))completeBlock;




@end
