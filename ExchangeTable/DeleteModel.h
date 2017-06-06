//
//  DeleteModel.h
//  ExchangeTable
//
//  Created by user44 on 2017/6/6.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeleteModel : NSObject

+(void)userid:(NSString*)userid gameid:(NSString*)gameid the_fetch:(void(^)(NSData *,NSURLResponse *,NSError *))block;

@end
