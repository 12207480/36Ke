//
//  LMNewsCell.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMNewsCell.h"
#import <UIImageView+WebCache.h>
#import "Common.h"
#import "NSDate+Extension.h"
@interface LMNewsCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) IBOutlet UILabel *typeLabel;

@end

@implementation LMNewsCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ChildData *)model {
    
    static NSString *ID = @"newsCell";
    LMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LMNewsCell class]) owner:nil options:nil] lastObject];
    }
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.featureImg]];
//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    cell.titleLabel.text = model.title;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.publishTime];
    

    cell.timeLabel.text = [NSDate stringFromDate:confromTimesp];
    cell.nameLabel.text = model.user.name;
    cell.typeLabel.text = model.columnName;
    if ([model.columnId isEqualToString:@"67"]) {
        cell.typeLabel.textColor = [UIColor greenColor];
    } else if ([model.columnId isEqualToString:@"68"]){
        cell.typeLabel.textColor = [UIColor cyanColor];
    } else if ([model.columnId isEqualToString:@"69"]){
        cell.typeLabel.textColor = [Common translateHexStringToColor:@"#"];
    } else if ([model.columnId isEqualToString:@"23"]){
        cell.typeLabel.textColor = [Common translateHexStringToColor:@"#"];
    } else if ([model.columnId isEqualToString:@"69"]){
        cell.typeLabel.textColor = [Common translateHexStringToColor:@"#"];
    } else if ([model.columnId isEqualToString:@"70"]){
        cell.typeLabel.textColor = [Common translateHexStringToColor:@"#"];
    } else if ([model.columnId isEqualToString:@"71"]){
        cell.typeLabel.textColor = [Common translateHexStringToColor:@"#"];
    }




    
    
    
    return cell;
}

@end

//switch (indexPath.row) {
//    case 0:
//        tabBar = [[LMTabBarController alloc] initColumn:nil title:@"新闻"];
//        break;
//    case 1:
//        tabBar = [[LMTabBarController alloc] initColumn:@"67" title:@"早起项目"];
//        break;
//    case 2:
//        tabBar = [[LMTabBarController alloc] initColumn:@"68" title:@"B轮后"];
//        break;
//    case 3:
//        tabBar = [[LMTabBarController alloc] initColumn:@"23" title:@"大公司"];
//        break;
//    case 4:
//        tabBar = [[LMTabBarController alloc] initColumn:@"69" title:@"资本"];
//        break;
//    case 5:
//        tabBar = [[LMTabBarController alloc] initColumn:@"70" title:@"深度"];
//        break;
//    case 6:
//        tabBar = [[LMTabBarController alloc] initColumn:@"71" title:@"研究"];
//        break;
//    case 7:
//        tabBar = [[LMTabBarController alloc] initColumn:@"tv" title:@"氪TV"];
//    default:
//        break;
//}

