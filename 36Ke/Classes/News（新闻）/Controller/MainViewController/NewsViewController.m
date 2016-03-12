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
#import "LMNavigationController.h"
#import "NewsListJsonHandler.h"
#import "LMNewsCell.h"
#import "KeTVCell.h"
#import "KeTVModel.h"
#import "ContentViewController.h"
#import "Common.h"
#import <MJExtension.h>
#import "NewsModel.h"
#import "KeTVModel.h"
#import "JSON.h"
@interface NewsViewController () <SDCycleScrollViewDelegate,HeaderListJsonHandlerDelegate,NewsListJsonHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    HeaderListJsonHandler *listHandler;
    NewsListJsonHandler *newsHandler;
    SDCycleScrollView *_cycleScrollView;
 
    
}

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, strong, readwrite) NSMutableArray *newsArray;

@property (nonatomic, strong) ChildData *childData;
@property (nonatomic, strong) KeTVData2 *ketvData2;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@property (nonatomic, assign) NSString *lastId;
@property (nonatomic, strong) NSString *column;
@property (nonatomic, strong) NSString *titleItem;

//@property (nonatomic, strong)


@end
@implementation NewsViewController

- (instancetype)initColumn:(NSString *)column title:(NSString *)title {
    _column = column;
    _titleItem = title;
    if (self = [super init]) {
//        self.navigationItem.title = title;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.update = YES;
    listHandler = [[HeaderListJsonHandler alloc] init];
    listHandler.delegate = self;
    newsHandler = [[NewsListJsonHandler alloc] init];
    newsHandler.delegate = self;
    [self setupUI];
    
    [self setupNaviItem];
    
    [self setupHeaderRefresh];
    
    [self cacheHistory];
    
    
    
//    _tableView.tableHeaderView = [self addHeaderView];
    
    
    
    // Do any additional setup after loading the view.
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(welcome) name:@"LMJAdvertisementKey" object:nil];
    //    self.tableView.headerHidden = NO;

   
}

- (void)viewWillAppear:(BOOL)animated
{
//    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"update"]) {
//        return;
//    }
    //    NSLog(@"bbbb");
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    
//    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

- (void)cacheHistory {
    
    if ([_column isEqualToString:@"all"]) {
        // 读取历史
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_header.txt"]];
        NSString *history = [Common readLocalString:path];
        
        NSError *error = nil;
        NSArray *array =
        [NSJSONSerialization JSONObjectWithData: [history dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &error];
        if (history.length>0) {
            _dataArray = [Pics mj_objectArrayWithKeyValuesArray:array];
            _tableView.tableHeaderView =  [self addHeaderView];
        }
    }

    
    
    // 读取历史
    NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",_column]];
    NSString *history = [Common readLocalString:path];
    
    NSError *error = nil;
    NSArray *array =
    [NSJSONSerialization JSONObjectWithData: [history dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
//    NSLog(@"%@",array);
    
//    NSData *data = [history dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *data2arry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
//    NSDictionary *dic=[Common readLocalString:path];
    
//    NSLog(@"dic---%@",dic[@"data"]);
//    NSLog(@"history---%@",history);
//    NSLog(@"hist--%@",[history JSONValue]);
//    NSMutableArray *resultarray = [[NSMutableArray alloc] init];
//    [resultarray addObject:history];
    if (history.length>0) {
        _update = NO;
        if ([_column hasPrefix:@"tv"]) {
            self.newsArray = [KeTVData2 mj_objectArrayWithKeyValuesArray:array];
            KeTVData2 *ketvData = self.newsArray.lastObject;
            _lastId = ketvData.tv.id;
        } else {
            self.newsArray = [ChildData mj_objectArrayWithKeyValuesArray:array];
            ChildData *dataChild = self.newsArray.lastObject;
            _lastId = dataChild.feedId;
        }
        NSLog(@"%@",_newsArray);
        [self.tableView reloadData];
        //获得所有分类数据
        //   NSLog(@"listData---%@",self.listData);
    }
    

}


- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:_tableView];
}

- (UIView *)addHeaderView {
    
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (Pics *pic in _dataArray) {
        [imagesURLStrings addObject:pic.imgUrl];
    }
    
    
    
    
    // 网络加载 --- 创建不带标题的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) imageURLStringsGroup:nil];
    
    _cycleScrollView.infiniteLoop = YES;
    
//    _cycleScrollView.autoScroll = NO;
    _cycleScrollView.delegate = self;
//    _cycleScrollView.placeholderImage=[UIImage imageNamed:@"homepagebannerplaceholder"];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 3.5; // 轮播时间间隔，默认1.0秒，可自定义
    
    
    //模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
//    });
    
    [header addSubview:_cycleScrollView];
    
    
    return header;
    
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
}


#pragma mark - HeaderListJsonHandlerDelegate
- (void)HeaderListJsonHandler:(HeaderListJsonHandler *)handler withResult:(NSMutableArray *)result {
   
//    NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%d.txt",currentCategory.PRKID]];
    
    _dataArray = [NSMutableArray arrayWithArray:result];
    
    _tableView.tableHeaderView =  [self addHeaderView];
    
    if (_dataArray.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
//    NSString *key = [result.keyEnumerator nextObject];
//    NSArray *temArray = result[key];
//    NSMutableArray *arrayM = [HeaderModel objectArrayWithKeyValuesArray:temArray];
//    NSLog(@"%@",arrayM);
}


#pragma mark - NewsListJsonHandlerDelegate
- (void)NewsListJsonHandler:(NewsListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type {
    
    if (result.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    if ([_column hasPrefix:@"tv"]) {
        _ketvData2  = result.lastObject;
        _lastId = _ketvData2.tv.id;
//        self.navigationController.title = _ketvData2.columnName;
    } else {
        
        _childData = result.lastObject;
        _lastId = _childData.feedId;
//        self.navigationController.title = _childData.columnName;
    }
//    _lastId = _childData.feedId;
    if (type == 1) {
//        NSString *writeString = [NSString stringWithFormat:@"%@",self.newsArray];
//        NSLog(@"writeString---%@",writeString);
//        /** 缓存newsArray,整个分类的数据都存入其中，我可以通过传入的column来判断文件名称是哪种数据
//          *  如果是全部，那么我命令文件可以是all,其他分类，可以通过传入的column命名，
//             缓存文件只存当时第一次传入的数据，读取数据也是一样的
//          */
//        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",_column]];
//        [Common writeString:writeString toPath:path];
        
        
        self.newsArray = result;
        
        
//        NSString *writeString = [NSString stringWithFormat:@"%@",self.newsArray];
//        NSLog(@"writeString---%@",writeString);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }else if(type == 2){
        [self.newsArray addObjectsFromArray:result];
        [self.tableView.mj_footer endRefreshing];
//        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }
    
}

- (void)NewsListJsonHandlerError:(NewsListJsonHandler *)handler error:(int)error {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)setupNaviItem {
    
//    // 设置背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_navigation"  target:(LMNavigationController *)self.navigationController action:@selector(showMenu)];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_search"  target:self action:@selector(commonSearch)];
    self.navigationItem.title = _titleItem;
    
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
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
//    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
////        MJRefreshBackStateFooter *footerSatae = [[MJRefreshBackStateFooter alloc] init];
////        [footerSatae setTitle:@"" forState:MJRefreshStateIdle];
////        [footerSatae setTitle:@"" forState:MJRefreshStateRefreshing];
//        [weakSelf loadMoreData];
//    }];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"LMJAdvertisementKey" object:nil];
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

//- (void)welcome
//{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
//    [self.tableView.mj_header beginRefreshing];
//}
#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    NSString *allUrlstring;
    if ([_column isEqualToString:@"all"]) {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news"];
    } else {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@",_column];
    }
//    allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?"];
    [self loadDataForType:1  column:_column  withURL:allUrlstring];
//    switch (_column) {
//        case 0:
//            [listHandler handlerHeaderObject];
//            [newsHandler handlerNewsObject:allUrlstring column:]
//            self.navigationItem.title = @"新闻";
//            break;
//            
//        default:
//            break;
//    }
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
//    https://rong.36kr.com/api/mobi/news?   https://rong.36kr.com/api/mobi/news?columnId=67
    NSString *allUrlstring;
//    NSString *allUrlstring;
    
    if ([_column isEqualToString:@"all"]) {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?lastId=%@",_lastId];
    }
//    } else if ([_column hasPrefix:@"tv"]) {
//        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?lastId=%@",_lastId];
//    }
    else {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@&lastId=%@",_column,_lastId];
    }
    
    [self loadDataForType:2 column:_column  withURL:allUrlstring];

}
// ------公共方法
- (void)loadDataForType:(int)type column:(NSString *)column withURL:(NSString *)allUrlstring
{
    if ([column isEqualToString:@"all"]) {
//        self.navigationItem.title = @"新闻";
        [listHandler handlerHeaderObject];
    }
//     self.navigationItem.title  = _childData.columnName;
    
    [newsHandler handlerNewsObject:allUrlstring type:type column:column];

}

#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_column hasPrefix:@"tv"]) {
        return 300.0f;
    }
    return 90.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_column hasPrefix:@"tv"]) {
        KeTVData2 *ketvModel = self.newsArray[indexPath.row];
        KeTVCell *cell = [KeTVCell cellWithTableView:tableView model:ketvModel];
        
        return cell;
    } else {
    
        ChildData *childModel = self.newsArray[indexPath.row];
    
        LMNewsCell * cell = [LMNewsCell cellWithTableView:tableView model:childModel];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    cell.chi = NewsModel;
    
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row]==self.newsArray.count)
    {
        return;
        
    }
    
    
    
    ChildData *dataChild = self.newsArray[indexPath.row];
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    [contentVC setChilData:dataChild];
    [contentVC setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
//    [contentVC sethide]
    [self.navigationController pushViewController:contentVC animated:YES];
    
//    [self presentViewController:contentVC animated:YES completion:nil];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
