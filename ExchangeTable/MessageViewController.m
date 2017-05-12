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
@property (nonatomic) NSMutableArray *catch;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.catch = [NSMutableArray new];
    [self.catch addObject:self.noteMessage.changeOutGame];
    [self.catch addObject:self.noteMessage.changeInGame];
    [self.catch addObject:self.noteMessage.contactMail];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.catch.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCellController *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    cell.detailContext.text = self.catch[indexPath.row];
    
    
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
