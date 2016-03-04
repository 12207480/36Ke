//
//  HeaderListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "HeaderListJsonHandler.h"
#import "LMNetworkTools.h"
#import <AFNetworking.h>
#import "HeaderModel.h"
#import "HttpTool.h"
@implementation HeaderListJsonHandler

- (void)handlerHeaderObject {
    
    [HttpTool get:@"https://rong.36kr.com/api/mobi/roundpics/v4?" params:nil success:^(id responseObj) {
        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];

    
//    NSString *url=@"https://rong.36kr.com/api/mobi/news";
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f];
//    AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
//    // NSLog(@"CoursesListJsonHandler--PostListJsonhandler---");
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *html = operation.responseString;
//        NSLog(@"%@",html);
//        if (self.delegate) {
//            [self.delegate HeaderListJsonHandler:self withResult:responseObject];
//            
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        [self initFailure];
//    }];
//    [operation start];
    
    
//    NSString *url=@"https://rong.36kr.com/api/mobi/news?";
//    [[[LMNetworkTools sharedNetworkTools]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//          NSLog(@"searchListWithKey---%@",[responseObject JSONValue]);
//        if (self.delegate) {
//            [self.delegate HeaderListJsonHandler:self withResult:responseObject];
//        }
//    
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }] resume];
    
}

@end
