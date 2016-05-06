//
//  TransaceTableViewCell.h
//  petegg
//
//  Created by czx on 16/5/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransaceTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * runAccoun; //流水（消费或者是进账）

@property(nonatomic,strong)UILabel * balance; //余额

@property(nonatomic,strong)UILabel * money; //余额的数目

@property(nonatomic,strong)UILabel * runAccounNumber; //流水具体数目

@property(nonatomic,strong)UILabel * data; //时间

@end
