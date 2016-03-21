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
#import "KeTVViewController.h"
@interface LMTabBarController ()

@property (nonatomic, strong) NewsViewController *newsViewController;

@property (nonatomic, strong) KeTVViewController *ketvViewController;

@property (nonatomic, strong) NSString * column;

@property (nonatomic, strong) NSString *naviItemtitle;

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVC];
    
}

- (instancetype)initColumn:(NSString *)column title:(NSString *)title {
    _column = column;
    _naviItemtitle = title;
    if (self = [super init]) {
        
    }
    
    return self;
}


- (void)addAllChildVC {
    if ([_column isEqualToString:@"tv"]) {
        KeTVViewController *ketvVC = [[KeTVViewController alloc] initColumn:_column title:_naviItemtitle];
        [self addChildVC:ketvVC title:@"新闻" imageName:@"tabbar_icon_news_meitu_1-1"];
        _ketvViewController = ketvVC;
    } else {
        NewsViewController *newsVC = [[NewsViewController alloc] initColumn:_column title:_naviItemtitle];
        //    UIImage *image = [UIImage imageNamed:@"tabbar_icon_news"];
        [self addChildVC:newsVC title:@"新闻" imageName:@"tabbar_icon_news_meitu_1-1"];
        _newsViewController = newsVC;
    }
    
    

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
