//
//  CatchTheModel.m
//  ExchangeTable
//
//  Created by user44 on 2017/6/2.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "CatchTheModel.h"
#import "AppDelegate.h"

@implementation CatchTheModel


+(void)userid:(NSString*)userid the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;
{
    NSString *internet = [NSString stringWithFormat:@"http://%@/catch_data.php",INTERNET];
    NSString *us = internet;
    NSURL *url = [NSURL URLWithString:us];
    NSMutableURLRequest *mr = [NSMutableURLRequest requestWithURL:url];
    
    mr.HTTPMethod = @"post";
    NSData *data_ps;
    NSString *pp = [NSString stringWithFormat:@"UserID=%@",userid];
    NSString *ps = pp;
    
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
