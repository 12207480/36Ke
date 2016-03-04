//
//  LMNewsCell.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMNewsCell.h"
#import <UIImageView+WebCache.h>

@interface LMNewsCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) IBOutlet UILabel *typeLabel;

@end

@implementation LMNewsCell

- (void)awakeFromNib {
    
    self.backgroundColor = LMJRGBColor(51, 52, 53);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(NewsModel *)model {
    
    static NSString *ID = @"newsCell";
    LMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LMNewsCell class]) owner:nil options:nil] lastObject];
    }
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.data.data[0][@"featureImg"]]];
//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
//    cell.titleLabel.text = model.data.data.title;
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.data.data.publishTime];
    

//    cell.timeLabel.text = [self stringFromDate:confromTimesp];
//    cell.nameLabel.text = model.data.data.user.name;
//    cell.typeLabel.text = model.data.data.columnName;
    
    return cell;
}

+ (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}
@end
