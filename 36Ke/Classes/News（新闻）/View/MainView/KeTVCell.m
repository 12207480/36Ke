//
//  KeTVCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "KeTVCell.h"
#import <UIImageView+WebCache.h>
@interface KeTVCell ()



@end

@implementation KeTVCell


- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



+ (instancetype)cellWithTableView:(UITableView *)tableView model:(KeTVData2 *)model {
    
    static NSString *ID = @"keTVCell";
    KeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KeTVCell class]) owner:nil options:nil] lastObject];
    }
    [cell.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.tv.featureImg]];

    cell.duration.text = model.tv.duration;
   
    cell.title.text = model.tv.title;
    
    return cell;
}


@end
