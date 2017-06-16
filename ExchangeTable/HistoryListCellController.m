//
//  HistoryListCellController.m
//  ExchangeTable
//
//  Created by user44 on 2017/5/23.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "HistoryListCellController.h"

@implementation HistoryListCellController

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
//    self.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.3];
    
//    float red = (arc4random()%)/10;
//    float green = (arc4random()%11)/10;
//    float blue = (arc4random()%11)/10;
//    NSLog(@"%f %f %f",red,green,blue);
//    
//    
//    self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.5];
    
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    frame.origin.x = 8;
    frame.size.width -= 15;
    frame.size.height -= frame.origin.x;
    //        self.layer.masksToBounds = YES;
    //        self.layer.cornerRadius = 45.0;
    [super setFrame:frame];
}

@end
