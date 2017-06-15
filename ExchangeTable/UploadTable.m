//
//  UploadTable.m
//  ExchangeTable
//
//  Created by user44 on 2017/5/12.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "UploadTable.h"

@interface UploadTable ()<UITextViewDelegate,UIScrollViewDelegate>

@end

@implementation UploadTable

- (void) cancel:(id)sender {
    
    [self.delegate didFinishSaveCancel:self.upLoadNote];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.upLoadNote);
    if (self.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    }
    
    
    UIScrollView *scrollView  = [UIScrollView new];
    scrollView.frame = self.view.frame;
    scrollView.contentSize = CGSizeMake(320, 550);
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackboard.png"]];
    
    [self.view addSubview:scrollView];
    
    UIButton *doneBtn = [UIButton new];
    [doneBtn sizeToFit];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [doneBtn.heightAnchor constraintEqualToConstant:50].active = YES;
//    [doneBtn setBackgroundColor:[UIColor redColor] ];
    doneBtn.backgroundColor = [UIColor orangeColor];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];

    UILabel *label1 = [UILabel new];
    label1.text = @"換出遊戲:";
    [scrollView addSubview:label1];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    [label1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    
    UITextView *textView1 = [UITextView new];
    textView1.tag = 10;
    textView1.delegate = self;
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.layer.cornerRadius = 5;
    textView1.layer.borderWidth = 1.0;
    textView1.layer.borderColor = [UIColor grayColor].CGColor;
    textView1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [scrollView addSubview:textView1];
    textView1.translatesAutoresizingMaskIntoConstraints = NO;
    [textView1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView1.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView1.topAnchor constraintEqualToAnchor:label1.bottomAnchor constant:5].active = YES;
    [textView1.heightAnchor constraintEqualToConstant:100].active = YES;
    textView1.inputAccessoryView = doneBtn;
    
    UILabel *label2 = [UILabel new];
    label2.text = @"換入遊戲:";
    [scrollView addSubview:label2];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    [label2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label2.topAnchor constraintEqualToAnchor:textView1.bottomAnchor constant:10].active = YES;
    
    UITextView *textView2 = [UITextView new];
    textView2.tag = 12;
    textView2.delegate = self;
    textView2.backgroundColor = [UIColor whiteColor];
    textView2.layer.cornerRadius = 5;
    textView2.layer.borderWidth = 1.0;
    textView2.layer.borderColor = [UIColor grayColor].CGColor;
    textView2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [scrollView addSubview:textView2];
    textView2.translatesAutoresizingMaskIntoConstraints = NO;
    [textView2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView2.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView2.topAnchor constraintEqualToAnchor:label2.bottomAnchor constant:5].active = YES;
    [textView2.heightAnchor constraintEqualToConstant:100].active = YES;
    textView2.inputAccessoryView = doneBtn;
    
    UILabel *label3 = [UILabel new];
    label3.text = @"交換地區:";
    [scrollView addSubview:label3];
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    [label3.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label3.topAnchor constraintEqualToAnchor:textView2.bottomAnchor constant:10].active = YES;
    
    UITextView *textView3 = [UITextView new];
    textView3.tag = 13;
    textView3.delegate = self;
    textView3.backgroundColor = [UIColor whiteColor];
    textView3.layer.cornerRadius = 5;
    textView3.layer.borderWidth = 1.0;
    textView3.layer.borderColor = [UIColor grayColor].CGColor;
    textView3.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [scrollView addSubview:textView3];
    textView3.translatesAutoresizingMaskIntoConstraints = NO;
    [textView3.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView3.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView3.topAnchor constraintEqualToAnchor:label3.bottomAnchor constant:5].active = YES;
    [textView3.heightAnchor constraintEqualToConstant:30].active = YES;
    textView3.inputAccessoryView = doneBtn;
    
    UILabel *label4 = [UILabel new];
    label4.text = @"交換方式：";
    [scrollView addSubview:label4];
    label4.translatesAutoresizingMaskIntoConstraints = NO;
    [label4.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label4.topAnchor constraintEqualToAnchor:textView3.bottomAnchor constant:10].active = YES;
    
    UITextView *textView4 = [UITextView new];
    textView4.tag = 14;
    textView4.delegate = self;
    textView4.backgroundColor = [UIColor whiteColor];
    textView4.layer.cornerRadius = 5;
    textView4.layer.borderWidth = 1.0;
    textView4.layer.borderColor = [UIColor grayColor].CGColor;
    textView4.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [scrollView addSubview:textView4];
    textView4.translatesAutoresizingMaskIntoConstraints = NO;
    [textView4.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView4.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView4.topAnchor constraintEqualToAnchor:label4.bottomAnchor constant:5].active = YES;
    [textView4.heightAnchor constraintEqualToConstant:30].active = YES;
    textView4.inputAccessoryView = doneBtn;
    
    UILabel *label5 = [UILabel new];
    label5.text = @"信箱：";
    [scrollView addSubview:label5];
    label5.translatesAutoresizingMaskIntoConstraints = NO;
    [label5.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [label5.topAnchor constraintEqualToAnchor:textView4.bottomAnchor constant:10].active = YES;
    
    UITextView *textView5 = [UITextView new];
    textView5.tag = 15;
    textView5.delegate = self;
    textView5.backgroundColor = [UIColor whiteColor];
    textView5.layer.cornerRadius = 5;
    textView5.layer.borderWidth = 1.0;
    textView5.layer.borderColor = [UIColor grayColor].CGColor;
    textView5.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.65];
    [scrollView addSubview:textView5];
    textView5.translatesAutoresizingMaskIntoConstraints = NO;
    [textView5.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [textView5.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [textView5.topAnchor constraintEqualToAnchor:label5.bottomAnchor constant:5].active = YES;
    [textView5.heightAnchor constraintEqualToConstant:30].active = YES;
    textView5.inputAccessoryView = doneBtn;
    
    UIButton *saveBtn = [UIButton new];
    [saveBtn setTitle:@"儲存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:0.87 green:0.42 blue:0.11 alpha:0.9]];
    saveBtn.layer.shadowOpacity = 0.5;
    saveBtn.layer.shadowOffset = CGSizeMake(3, 5);
    saveBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    
    saveBtn.layer.cornerRadius = 10;
    [scrollView addSubview:saveBtn];
    saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [saveBtn.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [saveBtn.topAnchor constraintEqualToAnchor:textView5.bottomAnchor constant:30].active = YES;
    [saveBtn.widthAnchor constraintEqualToConstant:self.view.bounds.size.width-40].active = YES;
    [saveBtn addTarget:self action:@selector(saveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    textView1.text = self.upLoadNote.changeOutGame;
    textView2.text = self.upLoadNote.changeInGame;
    textView3.text = self.upLoadNote.contactArea;
    textView4.text = self.upLoadNote.contactType;
    textView5.text = self.upLoadNote.contactMail;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) done{
        [self.view endEditing:YES];
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

-(void)saveBtnPressed:(UIButton *)sender{
    
    UITextView *textView1 = [self.view viewWithTag:10];
    UITextView *textView2 = [self.view viewWithTag:12];
    UITextView *textView3 = [self.view viewWithTag:13];
    UITextView *textView4 = [self.view viewWithTag:14];
    UITextView *textView5 = [self.view viewWithTag:15];
    
    if (self.presentingViewController) {
        
        if (textView1.text.length != 0&&textView2.text.length != 0&&textView3.text.length != 0&&textView4.text.length != 0&&textView5.text.length != 0) {
            
            [self.delegate didFinishSave:self.upLoadNote];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        
        if (textView1.text.length != 0&&textView2.text.length != 0&&textView3.text.length != 0&&textView4.text.length != 0&&textView5.text.length != 0) {
            
        [self.delegate didFinishDidUpdate:self.upLoadNote];
        [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark UIScrollViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (textView.tag == 10) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }else if (textView.tag ==12){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -50, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }else if (textView.tag ==13){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -120, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }else if (textView.tag == 14){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -180, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }else if (textView.tag == 15){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -250, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.tag == 10) {
        self.upLoadNote.changeOutGame = textView.text;
    }else if (textView.tag ==12){
        self.upLoadNote.changeInGame = textView.text;
    }else if (textView.tag ==13){
        self.upLoadNote.contactArea = textView.text;
    }else if (textView.tag == 14){
        self.upLoadNote.contactType = textView.text;
    }else if (textView.tag == 15){
        self.upLoadNote.contactMail = textView.text;
    }

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
