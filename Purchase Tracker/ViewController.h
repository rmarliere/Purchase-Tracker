//
//  ViewController.h
//  Purchase Tracker
//
//  Created by Rodrigo Marliere on 10/13/14.
//  Copyright (c) 2014 Rodrigo Marliere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTableViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddTableViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *purchasesArray;

- (IBAction)addPressed:(id)sender;
- (IBAction)editPressed:(id)sender;



@end
