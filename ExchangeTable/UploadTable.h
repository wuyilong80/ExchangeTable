//
//  UploadTable.h
//  ExchangeTable
//
//  Created by user44 on 2017/5/12.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@protocol UploadTableDelegate <NSObject>
-(void)didFinishSave:(Note *)unote;
-(void)didFinishSaveCancel:(Note *)cancelNote;
@end
@interface UploadTable : UIViewController
@property (nonatomic) Note *upLoadNote;
@property (weak,nonatomic) id <UploadTableDelegate> delegate;
@end
