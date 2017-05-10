//
//  MessageViewController.m
//  ExchangeTable
//
//  Created by Jayla on 2017/5/3.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "MessageViewController.h"
#import "Note.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableViewCell *mainImformation;
@property (weak, nonatomic) IBOutlet UITableView *messageList;

@property (nonatomic) NSMutableArray<Note *> *notes;
@end

@implementation MessageViewController
- (IBAction)addMessage:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageList.delegate = self;
    self.messageList.dataSource = self;
    
    self.notes = [NSMutableArray new];
    for (int k =1; k <= 10; k++) {
        Note *note = [Note new];
        note.messageNote = [NSString stringWithFormat:@"title %d",k];
        [self.notes addObject:note];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark MessageList Method

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    cell.textLabel.text = self.notes[indexPath.row].messageNote;
    
    return cell;
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
