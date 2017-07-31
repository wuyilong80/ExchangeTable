//
//  ConversationViewController.m
//  ExchangeTable
//
//  Created by user44 on 2017/6/13.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "ConversationViewController.h"
#import "ConverVCCellController.h"
#import "MessageNote.h"
#import "AppDelegate.h"
#import "MessageAddModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@import GoogleMobileAds;

@interface ConversationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,GADInterstitialDelegate>
{
    AppDelegate *ad;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *conversationTextField;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (nonatomic) NSMutableArray *messageData;
@property (nonatomic) UIRefreshControl *reFresh;

@end

@implementation ConversationViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.messageData = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.messageBtn.enabled = NO;
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (fbLogIn.emailCatch.length != 0) {
        self.messageBtn.enabled = YES;
    }
    
    [self messageDownload];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (ad.interstitial.isReady) {
        [ad.interstitial presentFromRootViewController:self];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ad = (AppDelegate*)[UIApplication sharedApplication].delegate ;
    
    ad.interstitial = [self createAndLoadInterstitial];
    
    self.conversationTextField.delegate = self;
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GEP-03.png"]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnOpen) name:@"FBisLogIn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnClose) name:@"FBisLogOut" object:nil];
    
    [SVProgressHUD showWithStatus:@"please wait"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillshow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillgone:) name:UIKeyboardWillHideNotification object:nil];
    
    self.reFresh = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.reFresh];
    [self.reFresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.reFresh.tintColor = [UIColor orangeColor];
    
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (GADInterstitial *)createAndLoadInterstitial {
    ad.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-1634421637328936/3334548209"];
    ad.interstitial.delegate = self;
    [ad.interstitial loadRequest:[GADRequest request]];
    return ad.interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    ad.interstitial = [self createAndLoadInterstitial];
}

-(void)refresh{
    
    [self messageDownload];
    
}

-(void) keyboardwillshow:(NSNotification*)sender {
    
    NSDictionary *dict = [sender userInfo];
    
    CGRect high = [[dict valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.view.bounds.size.width == 320) {
            self.view.frame = CGRectMake(0, -(self.view.bounds.size.height-high.size.height)*0.65, self.view.bounds.size.width, self.view.bounds.size.height);
        }else{
            self.view.frame = CGRectMake(0, -(self.view.bounds.size.height-high.size.height)/2, self.view.bounds.size.width, self.view.bounds.size.height);
        }
    }];
}

-(void) keyboardwillgone:(NSNotification*)sender{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            }];
}

-(void) btnOpen {
    
    self.messageBtn.enabled = YES;
    
}

-(void) btnClose {
    
    self.messageBtn.enabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) messageDownload {
    
    [MessageAddModel gameid:self.articleID the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@",error);
        }
        NSDictionary *pd;
        NSError *err_json;
        
        pd = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err_json];
        NSNumber *mysqli_errno = pd[@"mysqli_errno"];
        
        if([mysqli_errno intValue] == 0){
            
            [self.messageData removeAllObjects];
            NSArray *rows = pd[@"rows"];
            for (int k = 0; k < rows.count; k ++) {
                MessageNote *note = [MessageNote new];
                NSDictionary *er=rows[k];
                
                note.gameID = er[@"ID"];
                note.userID = er[@"UserID"];
                note.content = er[@"Content"];
                note.time = er[@"Time"];
                
                [self.messageData addObject:note];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
                if (fbLogIn.emailCatch.length != 0) {
                    self.messageBtn.enabled = YES;
                }
                
                [self.reFresh endRefreshing];
                [self.tableView reloadData];
                if(self.messageData.count>0)
                {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.messageData.count-1];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
            });
        }else{
            NSLog(@"mapd:mysqli_errno %@",mysqli_errno);
        }
    }];
}

- (IBAction)messageSendBtn:(UIButton*)sender {
    
    [SVProgressHUD showWithStatus:@"please wait"];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.conversationTextField resignFirstResponder];
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    
    if (self.conversationTextField.text.length != 0 ) {
        sender.enabled = NO;
    NSString *internet = [NSString stringWithFormat:@"https://wuyilong80.000webhostapp.com/message_add.php"];
    NSURL *url = [NSURL URLWithString:internet];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSDateFormatter *time = [[NSDateFormatter alloc]init];
    [time setDateStyle:NSDateFormatterShortStyle];
    [time setTimeStyle:NSDateFormatterShortStyle];
    NSString *poTime = [NSString stringWithFormat:@"%@",[time stringFromDate:[NSDate date]]];
    
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *params = [NSString stringWithFormat:@"GameID=%@&UserID=%@&Content=%@&Time=%@",self.articleID,fbLogIn.emailCatch,self.conversationTextField.text,poTime];
    
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
        
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.conversationTextField.text = @"";
            });
            [self messageDownload];
        }
    }]resume];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.conversationTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageBtn.translatesAutoresizingMaskIntoConstraints = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.messageData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [UIView new];
    
    [tableView addSubview:sectionView];
    
    return sectionView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return @"";
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    for (int x = 0; x < self.messageData.count; x++) {
        if (section == x) {
            return 1;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConverVCCellController *cell = [tableView dequeueReusableCellWithIdentifier:@"convercell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for (int x = 0; x < self.messageData.count; x++) {
        if (indexPath.section == x) {
    MessageNote *note=self.messageData[x];
    
    cell.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.2];
    cell.layer.cornerRadius = 10;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    cell.nameLabel.text= [NSString stringWithFormat:@"%@ :",note.userID];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.nameLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22];
    
    cell.contentLabel.text=note.content;
    cell.contentLabel.textColor = [UIColor purpleColor];
    cell.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    
    cell.timeLabel.text=note.time;
        }
    }
    return cell;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
