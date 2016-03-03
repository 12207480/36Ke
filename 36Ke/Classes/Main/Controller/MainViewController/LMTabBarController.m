//
//  LMTabBarController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMTabBarController.h"
#import "LMNavigationController.h"
#import "NewsViewController.h"

@interface LMTabBarController ()

@property (nonatomic, strong) NewsViewController *newsViewController;


@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVC];
    
}

- (void)addAllChildVC {
    NewsViewController *newsVC = [[NewsViewController alloc] init];
//    UIImage *image = [UIImage imageNamed:@"tabbar_icon_news"];
    
    [self addChildVC:newsVC title:@"新闻" imageName:@"tabbar_icon_news_meitu_1-1"];
    _newsViewController = newsVC;
    

}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName {
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
//    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    //声明这张图用原图
//    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
//    self.tabBarItem
    
    LMNavigationController *nav = [[LMNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

+ (void)initialize {
    
    UITabBarItem *apperance = [UITabBarItem appearance];
    [apperance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

@end
