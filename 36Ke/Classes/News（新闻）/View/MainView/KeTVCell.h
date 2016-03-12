//
//  KeTVCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeTVModel.h"
@interface KeTVCell : UITableViewCell

@property (nonatomic, strong) KeTVData2 *keTVModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(KeTVData2 *)model;


@end
