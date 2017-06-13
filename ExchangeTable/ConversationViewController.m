//
//  ConversationViewController.m
//  ExchangeTable
//
//  Created by user44 on 2017/6/13.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "ConversationViewController.h"
#import "ConverVCCellController.h"
#import "Note.h"
#import "AppDelegate.h"

@interface ConversationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *conversationTextField;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@end

@implementation ConversationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.messageBtn.enabled = NO;
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (fbLogIn.emailCatch.length != 0) {
        self.messageBtn.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blackboard.png"]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnOpen) name:@"FBisLogIn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnClose) name:@"FBisLogOut" object:nil];
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
- (IBAction)messageSendBtn:(id)sender {
    
    NSString *internet = [NSString stringWithFormat:@"https://wuyilong80.000webhostapp.com/message_add.php"];
    NSURL *url = [NSURL URLWithString:internet];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSDateFormatter *time = [[NSDateFormatter alloc]init];
    [time setDateStyle:NSDateFormatterShortStyle];
    NSString *poTime = [time stringFromDate:[NSDate date]];
    
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *params = [NSString stringWithFormat:@"GameID=%@&UserID=%@&Content=%@&Time=%@",self.articleID,fbLogIn.emailCatch,self.conversationTextField.text,poTime];
    
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }]resume];

    
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConverVCCellController *cell = [tableView dequeueReusableCellWithIdentifier:@"convercell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
