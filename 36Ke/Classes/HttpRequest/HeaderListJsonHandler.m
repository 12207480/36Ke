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
#import <MJExtension.h>
#import "Common.h"
@implementation HeaderListJsonHandler

- (void)handlerHeaderObject {
    
    [HttpTool get:@"https://rong.36kr.com/api/mobi/roundpics/v4?" params:nil success:^(id responseObj) {
        
        NSDictionary *dic = responseObj[@"data"];
        
        NSArray *array = dic[@"pics"];
        
        
        NSData *tempData = [self toJSONData:dic[@"pics"]];
        NSString *jsonString = [[NSString alloc] initWithData:tempData
                                                     encoding:NSUTF8StringEncoding];
        //        NSLog(@"array---%@",array);
        //        NSLog(@"dic[---%@",dic[@"data"]);
        
        
        //        NSString *writeString = [NSString stringWithFormat:@"%@",array];
        
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_header.txt"]];
        [Common writeString:jsonString toPath:path];
        
        
        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate HeaderListJsonHandler:self withResult:resultArray];
        }
        
//        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        NSLog(@"error:");
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
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
@end
