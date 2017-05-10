//
//  TheModel.h
//  apr19_mysql
//
//  Created by user44 on 2017/4/20.
//  Copyright © 2017年 user44. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheModel : NSObject

+(void)the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;

@end
