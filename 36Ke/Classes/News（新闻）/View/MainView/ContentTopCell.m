//
//  ContentTopCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "ContentTopCell.h"
#import <UIImageView+WebCache.h>
@interface ContentTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *summary;

@end


@implementation ContentTopCell


- (void)awakeFromNib {
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ContentData *)model {
    
    static NSString *ID = @"topCell";
    ContentTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContentTopCell class]) owner:nil options:nil] lastObject];
    }
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    //    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    cell.name.text = model.user.name;
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.publishTime];
    
    
//    cell.timeLabel.text = [NSDate stringFromDate:confromTimesp];
//    cell.nameLabel.text = model.user.name;
//    cell.typeLabel.text = model.columnName;
    
    return cell;

}

@end
