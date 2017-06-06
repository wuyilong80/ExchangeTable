//
//  CatchTheModel.h
//  ExchangeTable
//
//  Created by user44 on 2017/6/2.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CatchTheModel : NSObject
@property (nonatomic) NSString *userIds;

+(void)userid:(NSString*)userid the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;

@end
