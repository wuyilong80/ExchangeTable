//
//  HistoryList.m
//  ExchangeTable
//
//  Created by user44 on 2017/5/23.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "HistoryList.h"
#import "HistoryListCellController.h"
#import "UploadTable.h"
#import "Note.h"

@interface HistoryList ()<UITableViewDelegate,UITableViewDataSource,UploadTableDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Note *> *data;
@property (nonatomic) UILabel *sorryLabel;
@end

@implementation HistoryList

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.data = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    if (self.data.count == 0) {
        self.sorryLabel = [UILabel new];
        [self.sorryLabel setText:@"Sorry, You don't have any Data!"];
        [self.view addSubview:self.sorryLabel];
        self.sorryLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.sorryLabel.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:15].active = YES;
        [self.sorryLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addData:(id)sender {

    Note *upNote = [Note new];
    [self.data addObject:upNote];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    UploadTable *upLoadTable = [self.storyboard instantiateViewControllerWithIdentifier:@"upload"];
    upLoadTable.upLoadNote = upNote;
    upLoadTable.delegate = self;
    
    UINavigationController *addButton = [[UINavigationController alloc]initWithRootViewController:upLoadTable];
    [self presentViewController:addButton animated:YES completion:nil];
    
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryListCellController *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Note *note = self.data[indexPath.row];
    if (self.data.count > 0) {
        cell.textLabel.text = note.changeOutGame;
    }else{
        cell.textLabel.text = @"Sorry, You don't have any Data!";
    }
    
    return cell;
}

#pragma mark UploadTableDelegate

-(void)didFinishSave:(Note *)unote{
    
        NSURL *url = [NSURL URLWithString:@"http://localhost/note_add.php"];
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
    
        NSString *params = [NSString stringWithFormat:@"GameName=%@&WantGame=%@&Area=%@&ChangeType=%@&mail=%@",unote.changeOutGame,unote.changeInGame,unote.contactArea,unote.contactType,unote.contactMail];
    
        NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
        [request setHTTPBody:data];
    
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.sorryLabel setText:@""];
//                [self.adelegate didFinishSaveReLoad];
                NSInteger index = [self.data indexOfObject:unote];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }]resume];
}

-(void)didFinishSaveCancel:(Note *)cancelNote{
    
    NSInteger index = [self.data indexOfObject:cancelNote];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.data removeObject:cancelNote];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"modifysegue"]) {
        UploadTable *upLoad = segue.destinationViewController;
        NSIndexPath *i = [self.tableView indexPathForSelectedRow];
        Note *note=self.data[i.row];
        NSLog(@"%@",note);
        upLoad.upLoadNote = note;
        upLoad.delegate = self;
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
