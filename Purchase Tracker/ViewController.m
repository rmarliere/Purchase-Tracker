//
//  ViewController.m
//  Purchase Tracker
//
//  Created by Rodrigo Marliere on 10/13/14.
//  Copyright (c) 2014 Rodrigo Marliere. All rights reserved.
//

#import "ViewController.h"
#import "PurchaseTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.purchasesArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) addNewPurchase:(NSDictionary *)dictionary withIndex:(NSNumber *)index
{
    if ([index isEqual:nil])
    {
        index = 0;
    }
    [self.purchasesArray insertObject:dictionary atIndex:[index integerValue]];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PurchaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellPurchase"];
    
    if ( cell == nil )
    {
        cell = [[PurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellPurchase"];
    }
    
    NSDictionary *purchase = [self.purchasesArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text    = [purchase objectForKey:@"payee"];
    cell.subtitleLabel.text = [purchase objectForKey:@"description"];
    cell.totalLabel.text    = [purchase objectForKey:@"total"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.purchasesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self callAddVCWithDictionary:[self.purchasesArray objectAtIndex:indexPath.row] AndIndex:[NSNumber numberWithInteger:indexPath.row]];
    [self.purchasesArray removeObjectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.purchasesArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[[NSArray alloc]initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
    
    [self.tableView setEditing:NO animated:YES];

    [self.tableView reloadData];
}

- (IBAction)addPressed:(id)sender
{
    [self callAddVCWithDictionary:nil AndIndex:nil];
}

- (IBAction)editPressed:(id)sender
{
    BOOL editing = ![self.tableView isEditing];
    [self.tableView setEditing:editing animated:YES];
}

-(void) callAddVCWithDictionary:(NSDictionary *)dictionary AndIndex:(NSNumber *)index
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddTableViewController *addVC = [storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    addVC.delegate = self;
    addVC.dictionary = dictionary;
    addVC.index = index;
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
