//
//  CellController.m
//  ExchangeTable
//
//  Created by user44 on 2017/5/2.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "CellController.h"

@implementation CellController

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
//    self.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.0];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    frame.origin.x = 5;
    frame.size.width -= 10;
    frame.size.height -= frame.origin.x;
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 45.0;
    [super setFrame:frame];
}

@end
