//
//  ViewController.m
//  apr19_mysql
//
//  Created by user44 on 2017/4/19.
//  Copyright © 2017年 user44. All rights reserved.
//

#import "ViewController.h"
#import "TheModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *rows;
}
@property (weak, nonatomic) IBOutlet UITableView *the_tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [TheModel the_fetch:^(NSData *data, NSURLResponse *response, NSError *error) {
       
       NSLog(@"%@",error);
       NSDictionary *pd;
       NSError *err_json;
       
       pd = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err_json];
       
       NSNumber *mysqli_errno = pd[@"mysqli_errno"];
       
       if([mysqli_errno intValue] == 0){
       NSArray *rows = pd[@"rows"];
       self -> rows = rows;
       [self.the_tableView reloadData];
       }else{
           NSLog(@"mapd:mysqli_errno %@",mysqli_errno);
       }
       
   }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rows.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *er;
        er = rows [indexPath.row];
        NSLog(@"%@ %@ %@ %@",
              er[@"name"],
              er[@"account"],
              er[@"password"],
              er[@"phone"]);
    cell.textLabel.text = er[@"name"];
    cell.detailTextLabel.text = [er[@"amount"]description];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
