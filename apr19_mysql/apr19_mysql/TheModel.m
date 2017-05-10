//
//  TheModel.m
//  apr19_mysql
//
//  Created by user44 on 2017/4/20.
//  Copyright © 2017年 user44. All rights reserved.
//

#import "TheModel.h"

@implementation TheModel

+(void)the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;
{
    
    NSString *us = @"http://localhost/fetch_order.php";
    NSURL *url = [NSURL URLWithString:us];
    NSMutableURLRequest *mr = [NSMutableURLRequest requestWithURL:url];
    
    mr.HTTPMethod = @"post";
    NSData *data_ps;
    NSString *ps = @"kw=王小明";
    //ps = [ps stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    data_ps = [ps dataUsingEncoding:NSUTF8StringEncoding];
    mr.HTTPBody = data_ps;
    
    NSURLSession *session;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask;
    dataTask = [session dataTaskWithRequest:mr completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        block(data,response,error);
        
        }
    ];
    [dataTask resume];

    
}

@end
