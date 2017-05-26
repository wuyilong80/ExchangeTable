//
//  HistoryList.h
//  ExchangeTable
//
//  Created by user44 on 2017/5/23.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryListDelegate <NSObject>
-(void)didFinishSaveReLoad;
@end

@interface HistoryList : UIViewController
@property (nonatomic) id <HistoryListDelegate> adelegate;
@end
