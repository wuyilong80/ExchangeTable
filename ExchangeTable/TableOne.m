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

@interface TableOne ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Note *> *mainNotes;
@end

@implementation TableOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.mainNotes = [NSMutableArray new];
    [TheModel the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"%@",error);
        NSDictionary *pd;
        NSError *err_json;
        
        pd = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err_json];
        
        NSNumber *mysqli_errno = pd[@"mysqli_errno"];
        
        if([mysqli_errno intValue] == 0){
            
            NSArray *rows = pd[@"rows"];
            for (int k = 0; k < rows.count; k ++) {
                Note *note = [Note new];
                NSDictionary *er=rows[k];
                
                note.changeOutGame=er[@"GameName"];
                note.gameid = er[@"id"];
                note.changeInGame = er[@"WantGame"];
                note.contactMail = er[@"mail"];
                NSLog(@"%@",note.gameid);
                [self.mainNotes addObject:note];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"mapd:mysqli_errno %@",mysqli_errno);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


//#pragma mark UISearchBarDelegate
//
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    self.navigationController.navigationBar.hidden = TRUE;
//    CGRect r = self.view.frame;
//    r.origin.y = -44;
//    r.size.height += 44;
//    self.view.frame = r;
//    
//    [searchBar setShowsCancelButton:YES animated:YES];
//}
//
//
//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    [searchBar setShowsCancelButton:NO animated:YES];
//}
//
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//    self.navigationController.navigationBar.hidden = false;
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
