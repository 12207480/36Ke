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

@property (weak, nonatomic) IBOutlet UIImageView *featureImg;
@property (weak, nonatomic) IBOutlet UILabel *duration;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation KeTVCell


- (void)awakeFromNib {
    
//    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(KeTVData2 *)model {
    
    static NSString *ID = @"keTVCell";
    KeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KeTVCell class]) owner:nil options:nil] lastObject];
    }
    [cell.featureImg sd_setImageWithURL:[NSURL URLWithString:model.tv.featureImg]];
    //    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    cell.duration.text = model.tv.duration;
   
    
    
//    cell.title.text = [NSDate stringFromDate:confromTimesp];
    cell.title.text = model.tv.title;
//    cell.typeLabel.text = model.columnName;
    
    return cell;
}


@end
