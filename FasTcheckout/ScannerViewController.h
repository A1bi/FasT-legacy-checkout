//
//  ScannerViewController.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarScannerViewController.h"

@interface ScannerViewController : UIViewController <ZBarReaderDelegate>
{
	BarScannerViewController *scanner;
	NSMutableArray *tickets;
}

@property (retain, nonatomic) IBOutlet UIButton *scanBtn;
@property (retain, nonatomic) IBOutlet UITextField *numberField;
@property (retain, nonatomic) IBOutlet UILabel *ticketCounter;

- (IBAction)showScanner:(id)sender;
- (IBAction)checkId:(id)sender;
- (IBAction)showTickets:(id)sender;

@end
