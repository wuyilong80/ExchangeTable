//
//  MessageAddModel.h
//  ExchangeTable
//
//  Created by user44 on 2017/6/14.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageAddModel : NSObject

+(void)the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;

@end
