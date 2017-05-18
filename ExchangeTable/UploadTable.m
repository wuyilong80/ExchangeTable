//
//  UploadTable.m
//  ExchangeTable
//
//  Created by user44 on 2017/5/12.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "UploadTable.h"

@interface UploadTable ()<UITextViewDelegate>

@end

@implementation UploadTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"換出遊戲:";
    [self.view addSubview:label1];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    [label1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label1.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:15].active = YES;
    
    UITextView *textView1 = [UITextView new];
    textView1.delegate = self;
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.layer.cornerRadius = 5;
    textView1.layer.borderWidth = 1.0;
    textView1.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textView1];
    textView1.translatesAutoresizingMaskIntoConstraints = NO;
    [textView1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView1.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView1.topAnchor constraintEqualToAnchor:label1.bottomAnchor constant:5].active = YES;
    [textView1.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UILabel *label2 = [UILabel new];
    label2.text = @"換入遊戲:";
    [self.view addSubview:label2];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    [label2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label2.topAnchor constraintEqualToAnchor:textView1.bottomAnchor constant:10].active = YES;
    
    UITextView *textView2 = [UITextView new];
    textView2.delegate = self;
    textView2.backgroundColor = [UIColor whiteColor];
    textView2.layer.cornerRadius = 5;
    textView2.layer.borderWidth = 1.0;
    textView2.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textView2];
    textView2.translatesAutoresizingMaskIntoConstraints = NO;
    [textView2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView2.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView2.topAnchor constraintEqualToAnchor:label2.bottomAnchor constant:5].active = YES;
    [textView2.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UILabel *label3 = [UILabel new];
    label3.text = @"信箱:";
    [self.view addSubview:label3];
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    [label3.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label3.topAnchor constraintEqualToAnchor:textView2.bottomAnchor constant:10].active = YES;
    
    UITextView *textView3 = [UITextView new];
    textView3.delegate = self;
    textView3.backgroundColor = [UIColor whiteColor];
    textView3.layer.cornerRadius = 5;
    textView3.layer.borderWidth = 1.0;
    textView3.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textView3];
    textView3.translatesAutoresizingMaskIntoConstraints = NO;
    [textView3.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView3.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView3.topAnchor constraintEqualToAnchor:label3.bottomAnchor constant:5].active = YES;
    [textView3.heightAnchor constraintEqualToConstant:30].active = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        textView.frame = CGRectMake(20, 100, textView.bounds.size.width, textView.bounds.size.height);
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    textView.frame = CGRectMake(20, 10, textView.bounds.size.width, textView.bounds.size.height);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
