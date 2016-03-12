//
//  CommentCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "CommentCell.h"
#import <UIImageView+WebCache.h>
#import "CommentModel.h"
#import "NSDate+Extension.h"
@interface CommentCell ()



@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *createTime;

@end

@implementation CommentCell
- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(CommentData2 *)model {
    
    static NSString *ID = @"commentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommentCell class]) owner:nil options:nil] lastObject];
    }
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    //    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    cell.name.text = model.user.name;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.createTime];
    
   
    cell.createTime.text = [NSDate stringFromDate:confromTimesp];
//    cell.nameLabel.text = model.user.name;
    cell.content.text = model.content;
    int WordCount= cell.content.frame.size.width/15;
    CGFloat heightCount= cell.content.text.length / WordCount;
    [cell.content setFrame:CGRectMake(cell.content.frame.origin.x, 0, cell.content.frame.size.width,heightCount * 15 )];
    
//    [self nee]
//    [self layoutIfNeeded];
    return cell;
}
@end
