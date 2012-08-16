//
//  ScannerViewController.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"

@interface ScannerViewController : UIViewController <ZBarReaderDelegate>
{
	ZBarReaderViewController *readerVC;
}

@property (retain, nonatomic) IBOutlet UIButton *scanBtn;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (retain, nonatomic) IBOutlet UITextField *numberField;

- (IBAction)showScanner:(id)sender;
- (IBAction)checkId:(id)sender;

@end
