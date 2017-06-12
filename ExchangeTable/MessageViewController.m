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
    [mail setTitle:@"我想交換" forState:UIControlStateNormal];
    [mail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mail.frame = CGRectMake((self.view.bounds.size.width-100)/2.0, self.view.bounds.size.height-100, 100, 40);
    [mail setBackgroundColor:[UIColor colorWithRed:0.99 green:0.66 blue:0.34 alpha:0.6]];
    mail.layer.borderWidth = 1;
    mail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mail.layer.shadowOpacity = 0.5;
    mail.layer.shadowOffset = CGSizeMake(3, 5);
    mail.layer.shadowColor = [UIColor blackColor].CGColor;
    
    mail.layer.cornerRadius = 10;
    [self.view addSubview:mail];
    [mail addTarget:self action:@selector(sentMail) forControlEvents:UIControlEventTouchUpInside];

    
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
    
    self.smallTitle = @[@"換出遊戲:",@"換入遊戲:",@"交換地區:",@"交換方式:",@"信箱:",@"發文日期:"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
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
    
    cell.detailTitle.text = self.smallTitle[indexPath.row];
    cell.detailTitle.textColor = [UIColor whiteColor];
    
    cell.detailContext.text = self.detailNotes[indexPath.row];
    cell.detailContext.textColor = [UIColor whiteColor];
    
    return  cell;
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
