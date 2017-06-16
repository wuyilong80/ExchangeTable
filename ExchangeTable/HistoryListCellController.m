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
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    frame.origin.x = 8;
    frame.size.width -= 15;
    frame.size.height -= frame.origin.x;

    [super setFrame:frame];
}

@end
