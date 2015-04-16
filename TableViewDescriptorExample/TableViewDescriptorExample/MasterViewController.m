//
//  MasterViewController.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "MasterViewController.h"
#import "VSTableViewDescriptor.h"
#import "DetailsViewController.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) VSTableViewDescriptor* tableViewDescriptor;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wprotocol"

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    // table descriptor
    self.tableViewDescriptor = [[VSTableViewDescriptor alloc] init];
    
    // first section
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
    // add cells in first section
    NSArray* cells = @[@"Custom Section",@"Simple Section"];
    for (NSString* cellText in cells)
    {
        VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView* tableView, NSIndexPath *indexPath)
                                            {
                                                return 44;
                                                
                                            } configure:^UITableViewCell *(UITableView* tableView, NSIndexPath *indexPath)
                                            {
                                                UITableViewCell* cell = [weakSelf.tableView dequeueReusableCellWithIdentifier:@"StandartCell" forIndexPath:indexPath];
                                                cell.tag = indexPath.row;
                                                cell.textLabel.text = cellText;
                                                return cell;
                                                
                                            } select:^(UITableView* tableView, NSIndexPath *indexPath)
                                            {
                                                UITableViewCell* cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                                                [weakSelf performSegueWithIdentifier:@"DetailSegue" sender:cell];
                                            }];
        [cellDescriptor setWillDisplayBlock:^(UITableView* tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
            NSLog(@"willDisplayBlock");
        }];
        
        [sectionDescriptor addCellDescriptor:cellDescriptor];
    }
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    self.tableViewDescriptor.dataSource = self;
    self.tableViewDescriptor.delegate = self;
    
    // configure tableview
    self.tableView.delegate = self.tableViewDescriptor;
    self.tableView.dataSource = self.tableViewDescriptor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        UITableViewCell* cell = (UITableViewCell*)sender;
        BOOL customSection = (cell.tag == 0);
        [(DetailsViewController*)[segue destinationViewController] setCustomSection:customSection];
    }
}


@end

#pragma GCC diagnostic pop
