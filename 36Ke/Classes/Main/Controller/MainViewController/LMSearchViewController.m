//
//  LMSearchViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMSearchViewController.h"
#import "TokenTool.h"
#import "SearchListJsonHandler.h"
#import "SearchModel.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]

@interface LMSearchViewController ()  <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,SearchListJsonHandlerDelegate>
{
    SearchListJsonHandler *searchHandler;
}



/** 搜索文本框 */
@property (nonatomic, weak) LMSearchBar *search;
/** 历史搜索的tableView */
@property (nonatomic, strong) UITableView *historyTableView;
/** 搜索新闻/用户/公司的tableView */
@property (nonatomic, strong) UITableView *newsTableView;

//@property (nonatomic, strong) UITableView *showTableView;


@property (nonatomic,strong)NSMutableArray * searchHistory;

@property (nonatomic,strong) NSArray *myArray;//搜索记录的数组

@property (nonatomic, strong) SearchData *dataModel;

/** 获取SearchData数组数据 */
@property (nonatomic, strong) NSMutableArray *searchArray;

/** 获取OrgModel数组数据 */
@property (nonatomic, strong) NSArray *orgArray;

/** 获取CompanyModel数组数据 */
@property (nonatomic, strong) NSArray *companyArray;

/** 获取UserModel2数组数据 */
@property (nonatomic, strong) NSArray *userArray;

@end

@implementation LMSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    searchHandler = [[SearchListJsonHandler alloc] init];
    searchHandler.delegate = self;
    
    
    _searchHistory = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航条内容
    [self setNavigationItem];
    
    //初始化UI
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    //文本框获取焦点
    [super viewDidAppear:animated];
    [self.search becomeFirstResponder];
    
}


- (void)setNavigationItem
{
    LMSearchBar *searchBar = [LMSearchBar searchBar];
    CGFloat w = self.view.width * 0.85;
    searchBar.frame = CGRectMake(0, 0, w, 30);
    searchBar.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.search = searchBar;
    
    //取消按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(backClick)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightItem,nil];

    /** 调整导航条上leftBarButtonItem和rightBarButtonItem与屏幕边界的间距
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */

    
}
- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.historyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.historyTableView];
    
    
    
    
//    [self.his bringSubviewToFront:self.newsTableView];
//    self.newsTableView = self.historyTableView;
//    [self.view addSubview:self.newsTableView];
    
    
    
}

- (void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - SearchListJsonHandlerDelegate
- (void)SearchListJsonHandler:(SearchListJsonHandler *)handler withResult:(SearchData *)result {
    _dataModel = result;
//    NSLog(@"_dataModel---%@",_dataModel);
    _orgArray = _dataModel.org;
    _companyArray = _dataModel.company;
    _userArray = _dataModel.user;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField  {
    [self readNSUserDefaults];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField.text.length < 1) {
//        return;
//    }
//    // 封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"word"] = textField.text;
//    [searchHandler handlerSearchObject:@"https://rong.36kr.com/api/mobi/search" params:params];
    
//    NSLog(@"test");
    // 获得网络数据 reload一次
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"shouldChangeCharactersInRange textField---%@",textField.text);
//    NSLog(@"shouldChangeCharactersInRange string---%@",string);
    NSString *wordValue  = [NSString stringWithFormat:@"%@%@",textField.text,string];
//    NSLog(@"wordValue---!%@",wordValue);
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"word"] = wordValue;
    [searchHandler handlerSearchObject:@"https://rong.36kr.com/api/mobi/search" params:params];
//    [self.newsTableView reloadData];
//    NSLog(@"test");
    // 获得网络数据 reload一次
    if (wordValue.length == 1) {
//        self.historyTableView.hidden = YES;
        self.newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height) style:UITableViewStylePlain];
        self.newsTableView.delegate = self;
        self.newsTableView.dataSource = self;
        self.newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.newsTableView];
        
//        self.newsTableView.hidden = YES;
    }
    [self.newsTableView reloadData];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.newsTableView.hidden = YES;
    [self readNSUserDefaults];
    return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
////    NSLog(@"32131");
//}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"1232222");
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{//搜索方法
//     NSLog(@"567");
    if (textField.text.length > 0) {
//        [self readNSUserDefaults];
        // 缓存搜索记录, reload一次
        
        [TokenTool SearchText:textField.text];//缓存搜索记录
        [self readNSUserDefaults];
        
    }else{
        NSLog(@"请输入查找内容");
    }
    
    return YES;
}




#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.historyTableView) {
        return 2;
    } else {
        int count = 0;
        if (_orgArray.count) {
            count++;
        }
        if (_companyArray.count) {
            count++;
        }
        if (_userArray.count) {
            count++;
        }
        return count + 1;//
    }
//    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.historyTableView) {
        if (section==0) {
            if (_myArray.count>0) {
                return _myArray.count+1+1;
            }else{
                return 1;
            }
        }else{
            return 0;
        }

    } else {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            if (_dataModel.moreuser) {
                if (_userArray.count >= 3) {
                    return 3;
                }
                return _userArray.count;
            }
            if (_dataModel.morecompany) {
                if (_companyArray.count >= 3) {
                    return 3;
                }
                return _companyArray.count;
            }
            if (_orgArray.count) {
                if (_orgArray.count >= 3) {
                    return 3
                }
                return _orgArray.count;
            }
        } else {
            
        }
        return  1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.historyTableView) {
        if (indexPath.section==0) {
            if(indexPath.row ==0){
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                //            cell.sepa
                if (_myArray.count == 0) {
                    return cell;
                }
                cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                //            cell.
                cell.textLabel.text = @"历史搜索";
                cell.textLabel.textColor = fontCOLOR;
                return cell;
            }else if (indexPath.row == _myArray.count+1){
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                cell.textLabel.text = @"清除历史记录";
                cell.textLabel.textColor = [UIColor blueColor];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                return cell;
            }else{
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
                cell.textLabel.text = reversedArray[indexPath.row-1];
                return cell;
            }
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            return cell;
        }

    }  else {
        if(indexPath.row ==0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            //            cell.sepa
            if (_orgArray == 0 && _companyArray.count == 0 && _userArray.count == 0) {
                cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                //            cell.
                cell.textLabel.text = @"搜索新闻";
                cell.textLabel.textColor = fontCOLOR;
                return cell;
            }
        }else if (indexPath.row == _myArray.count+1){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"清除历史记录";
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
            cell.textLabel.text = reversedArray[indexPath.row-1];
            return cell;
        }
        
        
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
//        NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
        cell.textLabel.text = @"123";
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"[NSString stringWithUTF8String:object_getClassName(tableView)]--%@",[NSString stringWithUTF8String:object_getClassName(tableView)]);
    if (tableView == self.historyTableView) {
        if (section==0) {
            return 0;
        }else{
            return 0;
        }
    } else {

        NSLog(@"666");
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.historyTableView.estimatedRowHeight = 44.0f;
    //    self.searchTableView.estimatedRowHeight = 44.0f;
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.historyTableView) {
        [self.historyTableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == _myArray.count+1) {//清除所有历史记录
            [TokenTool removeAllArray];
            _myArray = nil;
            [self.historyTableView reloadData];
        }else{
            
        }
    } else {
        
    }
    
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    [self.historyTableView reloadData];
    NSLog(@"myArray======%@",myArray);
}

@end
