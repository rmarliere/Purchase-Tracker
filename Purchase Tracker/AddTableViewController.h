//
//  AddTableViewController.h
//  Purchase Tracker
//
//  Created by Rodrigo Marliere on 10/13/14.
//  Copyright (c) 2014 Rodrigo Marliere. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTableViewControllerDelegate;

@interface AddTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *payeeTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *amountTextField;
@property (strong, nonatomic) IBOutlet UITextField *tipTextField;
@property (strong, nonatomic) IBOutlet UITextField *totalTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSNumber *index;

@property (nonatomic, assign) id <AddTableViewControllerDelegate> delegate;

- (IBAction)savePressed:(id)sender;


@end

@protocol AddTableViewControllerDelegate

- (void) addNewPurchase:(NSDictionary *)dictionary withIndex:(NSNumber *)index;

@end

