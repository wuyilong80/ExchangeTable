//
//  TableOne.m
//  ExchangeTable
//
//  Created by user44 on 2017/4/27.
//  Copyright © 2017年 wuyilong. All rights reserved.
//

#import "TableOne.h"
#import "CellController.h"
#import "Note.h"
#import "TheModel.h"
#import "MessageViewController.h"
#import "HistoryList.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import FBSDKCoreKit;

@interface TableOne ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,UISearchControllerDelegate,FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Note *> *mainNotes;
@end

@implementation TableOne

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
            self.mainNotes = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self didFinishSaveReLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(self.view.bounds.size.width-95, 25, 90, loginButton.bounds.size.height);
    loginButton.layer.borderWidth = 0;
    loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginButton.layer.shadowOpacity = 0.8;
    loginButton.layer.shadowOffset = CGSizeMake(-2, 4);
    loginButton.layer.shadowColor = [UIColor blackColor].CGColor;

    [self.navigationController.view addSubview:loginButton];
    
    loginButton.readPermissions = @[@"email"];
    loginButton.delegate = self;
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error{
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    [[[FBSDKLoginManager alloc]init]logOut];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mainNotes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellController *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Note *note=self.mainNotes[indexPath.row];
    cell.mainContextLabel.text=note.changeOutGame;
    
    
    return  cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"messageSegue"]) {
        MessageViewController *message = segue.destinationViewController;
        NSIndexPath *i = [self.tableView indexPathForSelectedRow];
        Note *note=self.mainNotes[i.row];
        message.dnotes = note;
    }
}

-(void)didFinishSaveReLoad{
    
    [TheModel the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"%@",error);
        NSDictionary *pd;
        NSError *err_json;
        
        pd = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err_json];
        NSNumber *mysqli_errno = pd[@"mysqli_errno"];
        
        if([mysqli_errno intValue] == 0){
            
            [self.mainNotes removeAllObjects];
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

                [self.mainNotes insertObject:note atIndex:0];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"mapd:mysqli_errno %@",mysqli_errno);
        }
    }];
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
