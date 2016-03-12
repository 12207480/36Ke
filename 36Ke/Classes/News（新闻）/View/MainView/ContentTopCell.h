//
//  ContentTopCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
@interface ContentTopCell : UITableViewCell

@property (nonatomic, strong) ContentData *dataContent;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ContentData *)model;

@end
