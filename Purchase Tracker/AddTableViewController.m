//
//  AddTableViewController.m
//  Purchase Tracker
//
//  Created by Rodrigo Marliere on 10/13/14.
//  Copyright (c) 2014 Rodrigo Marliere. All rights reserved.
//

#import "AddTableViewController.h"

@interface AddTableViewController ()

@end

@implementation AddTableViewController

@synthesize dictionary = _dictionary;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.amountTextField.delegate   = self;
    self.tipTextField.delegate      = self;
    
    if ([self.dictionary isEqual:nil])
    {
        self.dictionary = [[NSDictionary alloc] init];
    }
    else
    {
        self.payeeTextField.text        = [self.dictionary objectForKey:@"payee"];
        self.dateTextField.text         = [self.dictionary objectForKey:@"date"];
        self.descriptionTextField.text  = [self.dictionary objectForKey:@"description"];
        self.amountTextField.text       = [self.dictionary objectForKey:@"amount"];
        self.tipTextField.text          = [self.dictionary objectForKey:@"tip"];
        self.totalTextField.text        = [self.dictionary objectForKey:@"total"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)savePressed:(id)sender
{
    if ([self isTipValid] && [self isAmountValid])
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [self.payeeTextField        text], @"payee",
                              [self.dateTextField         text], @"date",
                              [self.descriptionTextField  text], @"description",
                              [self.amountTextField       text], @"amount",
                              [self.tipTextField          text], @"tip",
                              [self.totalTextField        text], @"total",
                              nil];
        
        self.dictionary = dict;
        
        [self.delegate addNewPurchase:self.dictionary withIndex:self.index];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.totalTextField.text = [self calculateTotal];

    return NO;
}

- (BOOL)isAmountValid
{
    if ([[self getAmountTextField] floatValue] < 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Amount"
                                                        message:@"Amount can't be negative"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }
    return YES;
}

- (BOOL)isTipValid
{
    if ([[self getTipTextField] floatValue] > 100.00 || [[self getTipTextField] floatValue] < 0.00 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Tip"
                                                        message:@"Tip Must be between 0 and 100"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setLocale:[NSLocale currentLocale]];
    [currencyFormatter setMaximumFractionDigits:2];
    [currencyFormatter setMinimumFractionDigits:2];
    [currencyFormatter setNegativeFormat:@"-¤#,##0.00"];
    [currencyFormatter setAlwaysShowsDecimalSeparator:YES];
    
    if ([textField isEqual:self.amountTextField])
    {
        
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSNumber *someAmount = [NSNumber numberWithDouble:[textField.text doubleValue]];
        NSString *string = [currencyFormatter stringFromNumber:someAmount];
        
        textField.text = string;
    }
    else if ([textField isEqual:self.tipTextField])
    {
        [currencyFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber *someAmount = [NSNumber numberWithDouble:[textField.text doubleValue]];
        NSString *string = [currencyFormatter stringFromNumber:someAmount];
        
        textField.text = [NSString stringWithFormat:@"%@ %%", string];

    }
}

- (NSString *) calculateTotal
{
    float amount = [[self getAmountTextField] floatValue];
    float tip    = [[self getTipTextField]    floatValue];
    
    float total = ((amount/100) * tip) + amount;
    
    return [NSString stringWithFormat:@"$%.2f", total];
}

-(NSString *)getTipTextField
{
    return [self.tipTextField.text       stringByReplacingOccurrencesOfString:@"%" withString:@""];
}

-(NSString *)getAmountTextField
{
    NSString *amountString  = [self.amountTextField.text    stringByReplacingOccurrencesOfString:@"$" withString:@""];
    amountString            = [amountString                 stringByReplacingOccurrencesOfString:@"," withString:@""];
    return amountString;
}

@end
