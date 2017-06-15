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
#import "CatchTheModel.h"
@import FBSDKLoginKit;
@import FBSDKCoreKit;
#import "AppDelegate.h"
#import "DeleteModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppDelegate.h"

@interface HistoryList ()<UITableViewDelegate,UITableViewDataSource,UploadTableDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNote;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Note *> *data;
@property (nonatomic) UILabel *sorryLabel;
@property (nonatomic) NSString *emailCatch;
//@property (nonatomic) BOOL ddddd;
@end

@implementation HistoryList

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.data = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.data removeAllObjects];
    
    [self.tableView reloadData];

    self.addNote.enabled = NO;
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (fbLogIn.emailCatch.length != 0) {
        self.emailCatch = fbLogIn.emailCatch;
        [SVProgressHUD showWithStatus:@"please wait"];
        self.addNote.enabled = YES;
        [self didFinishSaveReLoad];
    }else{
        self.emailCatch = @"wxwxwxwxeqewqeqwfasfasf";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.ddddd = NO;
    
//    self.tableView.estimatedRowHeight = 50;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blackboard.png"]];
    
    UIBarButtonItem *delete = [[UIBarButtonItem alloc]initWithTitle:@"刪除" style:UIBarButtonItemStylePlain target:self action:@selector(deletedelete)];
    
    self.navigationItem.leftBarButtonItem = delete;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void) deletedelete {
    
//    if (self.ddddd == NO) {
//        [self.tableView setEditing:YES];
//        self.ddddd = YES;
//    }else{
//        [self.tableView setEditing:NO];
//        self.ddddd = NO;
//    }
    
    if (self.tableView.isEditing == NO) {
        [self.tableView setEditing:YES];
    }else{
        [self.tableView setEditing:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addData:(id)sender {
    
    Note *upNote = [Note new];
    upNote.userID = self.emailCatch;
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
    cell.textLabel.text = note.changeOutGame;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Note *note = self.data[indexPath.row];
    
    [DeleteModel userid:(NSString*)self.emailCatch gameid:(NSString*)note.gameid the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self.data removeObjectAtIndex:indexPath.row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

#pragma mark UploadTableDelegate

-(void)didFinishSave:(Note *)unote{
    
    NSString *internet = [NSString stringWithFormat:@"https://wuyilong80.000webhostapp.com/note_add.php"];
    NSURL *url = [NSURL URLWithString:internet];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSDateFormatter *time = [[NSDateFormatter alloc]init];
    [time setDateStyle:NSDateFormatterLongStyle];
    NSDate *poDate = [[NSDate alloc]init];
    unote.date = [time stringFromDate:poDate];
    
    NSString *params = [NSString stringWithFormat:@"GameName=%@&WantGame=%@&Area=%@&ChangeType=%@&mail=%@&UserID=%@&Date=%@",unote.changeOutGame,unote.changeInGame,unote.contactArea,unote.contactType,unote.contactMail,unote.userID,unote.date];
    
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

-(void)didFinishSaveCancel:(Note *)cancelNote{
    
//    NSInteger index = [self.data indexOfObject:cancelNote];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.data removeObject:cancelNote];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
}

-(void)didFinishDidUpdate:(Note *)updateNote{
    
    NSString *internet = [NSString stringWithFormat:@"https://wuyilong80.000webhostapp.com/update_note.php"];
    NSURL *url = [NSURL URLWithString:internet];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"GameName=%@&WantGame=%@&Area=%@&ChangeType=%@&mail=%@&gameid=%@",updateNote.changeOutGame,updateNote.changeInGame,updateNote.contactArea,updateNote.contactType,updateNote.contactMail,updateNote.gameid];
    NSLog(@"%@",updateNote.gameid);
    
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.sorryLabel setText:@""];
                NSInteger index = [self.data indexOfObject:updateNote];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }]resume];
    
}

-(void)didFinishSaveReLoad{
    
    [CatchTheModel userid:(NSString*)self.emailCatch the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"%@",error);
        NSDictionary *pd;
        NSError *err_json;
        
        pd = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err_json];
        NSNumber *mysqli_errno = pd[@"mysqli_errno"];
        
        if([mysqli_errno intValue] == 0){
            
            [self.data removeAllObjects];
            NSArray *rows = pd[@"rows"];
            for (int k = 0; k < rows.count; k ++) {
                Note *note = [Note new];
                NSDictionary *er=rows[k];
                
                note.gameid = er[@"id"];
                note.changeOutGame = er[@"GameName"];
                note.changeInGame = er[@"WantGame"];
                note.contactMail = er[@"mail"];
                note.contactArea = er[@"Area"];
                note.contactType = er[@"ChangeType"];
                
                [self.data insertObject:note atIndex:0];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"mapd:mysqli_errno %@",mysqli_errno);
        }
    }];
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
