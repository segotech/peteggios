//
//  SquareListModel.h
//  MBProgressHUD
//
//  Created by ldp on 16/03/23
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"


@interface SquareModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *address;

@property (nonatomic, copy) NSString<Optional> *content;

@property (nonatomic, copy) NSString<Optional> *status;

@property (nonatomic, copy) NSString<Optional> *praises;

@property (nonatomic, copy) NSString<Optional> *mid;

@property (nonatomic, copy) NSString<Optional> *pet_age;

@property (nonatomic, copy) NSString<Optional> *nickname;

@property (nonatomic, copy) NSString<Optional> *isfriend;

@property (nonatomic, copy) NSString<Optional> *attributive;

@property (nonatomic, copy) NSString<Optional> *views;

@property (nonatomic, copy) NSString<Optional> *pet_race;

@property (nonatomic, copy) NSString<Optional> *stid;

@property (nonatomic, copy) NSString<Optional> *pet_sex;

@property (nonatomic, copy) NSString<Optional> *type;

@property (nonatomic, copy) NSString<Optional> *resources;

@property (nonatomic, copy) NSString<Optional> *publishuser;

@property (nonatomic, copy) NSString<Optional> *comments;

@property (nonatomic, copy) NSString<Optional> *headportrait;

@property (nonatomic, copy) NSString<Optional> *thumbnails;

@property (nonatomic, copy) NSString<Optional> *publishtime;

@property (nonatomic, copy) NSString<Optional> *reports;

@end
@protocol RecommendModel
@end

@interface SquareListModel : BaseModel

//@property (nonatomic, strong) NSArray *listToXML;

//@property (nonatomic, strong) NSArray *dlist;

@property (nonatomic, copy) NSString<Optional> *totalrecords;

@property (nonatomic, strong) NSMutableArray<RecommendModel, Optional> *list;

@end