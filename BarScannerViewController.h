//
//  BarScannerViewController.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 18.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "ZBarReaderViewController.h"

@interface BarScannerViewController : ZBarReaderViewController
{
	UILabel *counter;
}

- (void)updateCounter:(NSInteger)count;

@end
