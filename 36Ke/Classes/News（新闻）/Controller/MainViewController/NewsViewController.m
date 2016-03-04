//
//  NewsViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewsViewController.h"
#import "HeaderListJsonHandler.h"
#import "HeaderModel.h"
#import "LMNewsRefreshHeader.h"
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
#import <MJExtension.h>
@interface NewsViewController () <SDCycleScrollViewDelegate,HeaderListJsonHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    HeaderListJsonHandler *listHandler;
    SDCycleScrollView *_cycleScrollView;
    CGFloat lastContentOffset;
}

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@end
@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _tableView.tableHeaderView = [self addHeaderView];
    
    [self setupUI];
    
    [self setupNaviItem];
    
    [self setupHeaderRefresh];
    
    
    
    listHandler = [[HeaderListJsonHandler alloc] init];
    listHandler.delegate = self;
    
    // Do any additional setup after loading the view.
    
   
}


- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:_tableView];
}

//- (UIView *)addHeaderView {
//    
////    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
//}


#pragma mark - HeaderListJsonHandlerDelegate
- (void)HeaderListJsonHandler:(HeaderListJsonHandler *)handler withResult:(NSDictionary *)result {
    
    NSString *key = [result.keyEnumerator nextObject];
    NSArray *temArray = result[key];
    NSMutableArray *arrayM = [HeaderModel objectArrayWithKeyValuesArray:temArray];
    NSLog(@"%@",arrayM);
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

- (void)setupHeaderRefresh {
    
    
    
//    __unsafe_unretained __typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置回调（一旦进入下拉刷新刷新状态就会调用这个refreshingBlock）
    LMNewsRefreshHeader *header = [LMNewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏文字
//    header.
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    // 设置回调（一旦进入上拉刷新刷新状态就会调用这个refreshingBlock）
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
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
    [listHandler handlerHeaderObject];
    
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    
}
// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    
}

//#pragma mark - UITableViewDelegate
//
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80.0f;
//}
//
//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//    
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}



@end
