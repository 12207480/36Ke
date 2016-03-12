//
//  LMCommentViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMCommentViewController.h"
#import "CommentListJsonHandler.h"
#import "CommentModel.h"
#import "LMNewsRefreshHeader.h"
#import "CommentCell.h"
#import "LMNavigationController.h"
@interface LMCommentViewController () <CommentListJsonHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CommentListJsonHandler *commentHandler;
}


@property (nonatomic, strong, readwrite) NSMutableArray *commentArray;

@property (nonatomic, strong) CommentData2 *dataComment;

@property (nonatomic, strong) ChildData *dataChild;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@property (nonatomic, strong) NSString *lastId;

//@property (nona)


@end

@implementation LMCommentViewController

- (void)initChildData:(ChildData *)dataChild commentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    _dataChild = dataChild;
    _lastId = _dataChild.feedId;
    
//    if (self = [super init]) {
//        
//    }
//    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    commentHandler = [[CommentListJsonHandler alloc] init];
    commentHandler.delegate = self;
    self.update = YES;
    [self setupUI];
    [self setupNaviItem];
    [self setupHeaderRefresh];
    self.update = YES;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    
//    self.navigationItem.title = @"12345";
    
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


- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:_tableView];
}

- (void)setupNaviItem {
    NSString *comment = [NSString stringWithFormat:@"%ld条记录",_commentCount];
    self.navigationItem.title = comment;
//    LMNavigationController *naviVC = [[LMNavigationController alloc] init];
    
//    naviVC.title = @"123";
//    self.navigationItem.title = @"back2";
    //    // 设置背景
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_back"  target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"写评论" titleColor:nil target:self action:@selector(writeComment)];
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_back"  target:self action:@selector(back)];
//    self.navigationItem.title = comment;
    
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)writeComment {
    
}



- (void)setupHeaderRefresh {
    
    
    
    //    __unsafe_unretained __typeof(self) weakSelf = self;
    //    self.view.backgroundColor = [UIColor whiteColor];
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


#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    NSLog(@"_lastId----%@",_lastId);
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news/comments/%@",_lastId];
    //    if (_column == nil) {
    //        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news"];
    //    } else {
    //        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@",_column];
    //    }
    //    allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?"];
    [self loadDataForType:1   withURL:allUrlstring];
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
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news/comments/%@?lastId=%@",_dataChild.feedId,_lastId];
    [self loadDataForType:2   withURL:allUrlstring];
    
}
// ------公共方法
- (void)loadDataForType:(int)type  withURL:(NSString *)allUrlstring
{
    
    [commentHandler handlerCommentObject:allUrlstring  type:type];
    //    [commentHandler handlerCommentObject:allUrlstring childData:_dataChild  type:type];
    
}


#pragma mark - CommentListJsonHandlerDelegate
- (void)CommentListJsonHandler2:(CommentListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type {
    
    if (result.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    _dataComment = result.lastObject;
    _lastId = [NSString stringWithFormat:@"%ld",_dataComment.postId];
    if (type == 1) {
        self.commentArray = result;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }else if(type == 2){
        [self.commentArray addObjectsFromArray:result];
        [self.tableView.mj_footer endRefreshing];
        //        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }
}



#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentData2 *dataComment = _commentArray[indexPath.row];
    
    CommentCell *commentCell = [CommentCell cellWithTableView:tableView model:dataComment];
    CGSize size = [commentCell.content systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    NSLog(@"size---%lf",size.height);
    //    NSLog(@"CGRectGetMaxY(commentCell.content.frame) ---%lf",CGRectGetMaxY(commentCell.content.frame));
    return CGRectGetMaxY(commentCell.content.frame) + size.height   + 40;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentData2 *dataComment = _commentArray[indexPath.row];
    CommentCell *commentCell = [CommentCell cellWithTableView:tableView model:dataComment];
    commentCell.selectionStyle = UITableViewCellSelectionStyleGray;
    return commentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([indexPath row]==self.newsArray.count)
    //    {
    //        return;
    //
    //    }
    //    ChildData *dataChild = self.newsArray[indexPath.row];
    //    ContentViewController *contentVC = [[ContentViewController alloc] init];
    //    [contentVC setChilData:dataChild];
    //
    //    [self presentViewController:contentVC animated:YES completion:nil];
    //
    //    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
