//
//  MessageAddModel.m
//  ExchangeTable
//
//  Created by user44 on 2017/6/14.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "MessageAddModel.h"
#import "AppDelegate.h"

@implementation MessageAddModel

+(void)gameid:(NSString*)gameid the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;
{
    
    NSString *internet = [NSString stringWithFormat:@"https://wuyilong80.000webhostapp.com/message_order.php"];
    NSString *us = internet;
    NSURL *url = [NSURL URLWithString:us];
    NSMutableURLRequest *mr = [NSMutableURLRequest requestWithURL:url];
    
    mr.HTTPMethod = @"post";
    NSData *data_ps;
    NSString *ps = [NSString stringWithFormat:@"kw=%@",gameid];
;
    
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
