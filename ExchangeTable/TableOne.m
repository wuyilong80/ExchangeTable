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
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppDelegate.h"

@interface TableOne ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,UISearchControllerDelegate,FBSDKLoginButtonDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Note *> *mainNotes;
@property (nonatomic) NSString *emailCatch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) UIRefreshControl *refreshControl;
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
    
    [SVProgressHUD showWithStatus:@"please wait"];
    [self didFinishSaveReLoad:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blackboard.png"]];
    
    self.searchBar.delegate = self;
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(self.view.bounds.size.width-100, 25, 90, loginButton.bounds.size.height);
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
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];    
    self.refreshControl.tintColor = [UIColor whiteColor];
    
}

-(void)refresh{
    
    [self didFinishSaveReLoad:@""];
}

#pragma mark UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self didFinishSaveReLoad:searchText];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    self.searchBar.showsCancelButton = YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    self.searchBar.showsCancelButton = NO;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark FBSDKLogin

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error{
    
    NSMutableDictionary *fbDict = [NSMutableDictionary dictionary];
    [fbDict setValue:@"email" forKey:@"fields"];
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:fbDict];
        
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            NSDictionary *info = result;
            NSLog(@"email = %@",info[@"email"]);
            NSString *str = info[@"email"];
            if (str.length != 0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"FBisLogIn" object:self userInfo:nil];
                AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
                fbLogIn.emailCatch = info[@"email"];
            }
        }];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    [[[FBSDKLoginManager alloc]init]logOut];
    AppDelegate *fbLogIn = (AppDelegate*)[UIApplication sharedApplication].delegate;
    fbLogIn.emailCatch = @"";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FBisLogOut" object:self userInfo:nil];

}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.mainNotes.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
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
    
    for (int x = 0; x < self.mainNotes.count; x++) {
        if (section == x) {
            return 1;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellController *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for (int x = 0; x < self.mainNotes.count; x++) {
        if (indexPath.section == x) {
            Note *note=self.mainNotes[x];
            
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
            cell.layer.cornerRadius = 10;
            
            cell.mainContextLabel.text=note.changeOutGame;
            cell.mainContextLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            cell.mainContextLabel.textColor = [UIColor lightTextColor];
            
            cell.mainTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
            cell.mainTitleLabel.textColor = [UIColor whiteColor];
        }
    }
    return  cell;
}

#pragma mark prepareForSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"messageSegue"]) {
        MessageViewController *message = segue.destinationViewController;
        NSIndexPath *i = [self.tableView indexPathForSelectedRow];
        Note *note=self.mainNotes[i.section];
        message.dnotes = note;
        message.emailcatch = self.emailCatch;
    }
}

-(void)didFinishSaveReLoad:(NSString*)search{
    
    [TheModel search:search the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
                note.date = er[@"Date"];
                
                [self.mainNotes insertObject:note atIndex:0];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.refreshControl endRefreshing];

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
