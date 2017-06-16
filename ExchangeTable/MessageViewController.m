//
//  MessageViewController.m
//  ExchangeTable
//
//  Created by Jayla on 2017/5/3.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "MessageViewController.h"
#import "Note.h"
#import "MessageCellController.h"
#import "ConversationViewController.h"
#import "AppDelegate.h"

@interface MessageViewController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *detailNotes;
@property (nonatomic) NSArray *smallTitle;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blackboard.png"]];
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIButton *mail = [UIButton new];
    [mail setTitle:@"信箱交換" forState:UIControlStateNormal];
    [mail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mail.frame = CGRectMake((self.view.bounds.size.width-200)/2, self.view.bounds.size.height-100, 100, 40);
    [mail setBackgroundColor:[UIColor colorWithRed:0.99 green:0.66 blue:0.34 alpha:0.3]];
    mail.layer.borderWidth = 1.5;
    mail.layer.borderColor = [UIColor grayColor].CGColor;
    mail.layer.shadowOpacity = 0.5;
    mail.layer.shadowOffset = CGSizeMake(3, 5);
    mail.layer.shadowColor = [UIColor blackColor].CGColor;
    mail.layer.cornerRadius = 10;
    [self.view addSubview:mail];
    [mail addTarget:self action:@selector(sentMail) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leaveMessage = [UIButton new];
    [leaveMessage setTitle:@"留言交換" forState:UIControlStateNormal];
    [leaveMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaveMessage setBackgroundColor:[UIColor colorWithRed:0.52 green:0.76 blue:1.00 alpha:0.3]];
    leaveMessage.frame = CGRectMake(((self.view.bounds.size.width-200)/2.0)+100, self.view.bounds.size.height-100, 100, 40);
    leaveMessage.layer.borderWidth = 1.5;
    leaveMessage.layer.borderColor = [UIColor grayColor].CGColor;
    leaveMessage.layer.shadowOpacity = 0.5;
    leaveMessage.layer.shadowOffset = CGSizeMake(3, 5);
    leaveMessage.layer.shadowColor = [UIColor blackColor].CGColor;
    leaveMessage.layer.cornerRadius = 10;
    [self.view addSubview:leaveMessage];
    [leaveMessage addTarget:self action:@selector(leaveMessagePressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailNotes = [NSMutableArray new];
    [self.detailNotes addObject:self.dnotes.changeOutGame];
    [self.detailNotes addObject:self.dnotes.changeInGame];
    [self.detailNotes addObject:self.dnotes.contactArea];
    [self.detailNotes addObject:self.dnotes.contactType];
    [self.detailNotes addObject:self.dnotes.contactMail];
    
    [self.detailNotes addObject:self.dnotes.date];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView setTableFooterView:[UIView new]];
    
    self.smallTitle = @[@"想換出的遊戲:",@"想換入的遊戲:",@"交換地區:",@"交換方式:",@"信箱:",@"發文日期:"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
}
-(void) leaveMessagePressed {
    
    [self performSegueWithIdentifier:@"conversationsegue" sender:nil];
}

-(void) sentMail {
    
    NSDictionary *fake = nil;
    
    NSString *URLEMail = [NSString stringWithFormat:@"mailto:%@?subject=我想交換",self.detailNotes[4]];
    
    NSString *url = [URLEMail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    NSURL *uurrll = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:uurrll options:fake completionHandler:nil];
}

- (IBAction)swipe:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.detailNotes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCellController *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.1];
    
    cell.detailTitle.text = self.smallTitle[indexPath.row];
    cell.detailTitle.textColor = [UIColor whiteColor];
    
    cell.detailContext.text = self.detailNotes[indexPath.row];
    cell.detailContext.textColor = [UIColor whiteColor];
    
    return  cell;
}

#pragma mark prepareForSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"conversationsegue"]) {
        ConversationViewController *conversationVC = segue.destinationViewController;
        conversationVC.articleID = self.dnotes.gameid;        
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
