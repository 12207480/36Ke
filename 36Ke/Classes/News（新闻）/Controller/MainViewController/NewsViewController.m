//
//  NewsViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewsViewController.h"
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
@interface NewsViewController () <SDCycleScrollViewDelegate>
{
    
}

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@end
@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LMJRGBColor(240, 243, 245);
    // Do any additional setup after loading the view.
    [self setupNaviItem];

}

- (void)setupNaviItem {
    
//    // 设置背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_navigation"  target:self action:@selector(commonSwitch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_search"  target:self action:@selector(commonSearch)];
    self.navigationItem.title = @"新闻";
    
}
- (void)commonSwitch {
    
}

- (void)commonSearch {
    
}

- (void)setRefresh {
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor clearColor];
    // 设置回调（一旦进入下拉刷新刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    // 设置回调（一旦进入上拉刷新刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.update = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"LMJAdvertisementKey" object:nil];
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)welcome
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:allUrlstring];
    
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString  stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.dataArray.count - self.dataArray.count % 10)];
    [self loadDataForType:2 withURL:allUrlstring];
}
// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
//    [[LMJNetworkTools sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//        NSLog(@"LMJNewsTableViewController--!%@",allUrlstring);
//        NSString *key = [responseObject.keyEnumerator nextObject];
//        NSArray *tempArray = responseObject[key];
//        //        NSLog(@"tempArray--%@",tempArray);
//        NSMutableArray *arrayM = [T1348647853363 objectArrayWithKeyValuesArray:tempArray];
//        //        NSLog(@"arrayM--%@",arrayM[0][@"title"]);
//        //        for (T1348647853363 *t1348647853363 in arrayM) {
//        //            NSLog(@"T1348647853363---%@",t1348647853363.title);
//        //        }
//        if (type == 1) {
//            self.arrayList = arrayM;
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView reloadData];
//        } else if (type == 2) {
//            [self.arrayList addObjectsFromArray:arrayM];
//            [self.tableView.mj_footer endRefreshing];
//            [self.tableView reloadData];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"LoadDataForType,error:%@",error);
//    }];
    
}

//#pragma mark - UITableViewDelegate
//
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}



@end
