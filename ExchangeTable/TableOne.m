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

@interface TableOne ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic) NSMutableArray<Note *> *notes;
@end

@implementation TableOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.notes = [NSMutableArray new];
    for (int k =1; k <= 10; k++) {
        Note *note = [Note new];
        note.title = [NSString stringWithFormat:@"titleqeqwucyaubsuyflhclahlafhlwfuhlnwawflcfuwlhfclnwhilfnehwlfwcanefufhcnlwfdhskahf %d",k];
//        note.image = [UIImage imageNamed:@"apple.jpg"];
        [self.notes addObject:note];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellController *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.labelCell.text = self.notes[indexPath.row].title;
   
    return  cell;
}



#pragma mark UISearchBarController


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
