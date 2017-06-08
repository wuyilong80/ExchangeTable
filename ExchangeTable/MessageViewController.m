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
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.detailNotes = [NSMutableArray new];
    [self.detailNotes addObject:self.dnotes.changeOutGame];
    [self.detailNotes addObject:self.dnotes.changeInGame];
    [self.detailNotes addObject:self.dnotes.contactArea];
    [self.detailNotes addObject:self.dnotes.contactType];
    [self.detailNotes addObject:self.dnotes.contactMail];
//    [self.detailNotes addObject:self.dnotes.date];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView setTableFooterView:[UIView new]];
    
    self.smallTitle = @[@"換出遊戲:",@"換入遊戲:",@"交換地區:",@"交換方式:",@"信箱:",@"發文日期"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    
    cell.detailTitle.text = self.smallTitle[indexPath.row];
    
    cell.detailContext.text = self.detailNotes[indexPath.row];
    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
