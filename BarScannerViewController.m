//
//  BarScannerViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 18.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "BarScannerViewController.h"

@interface BarScannerViewController ()

- (void)dismissScanner;

@end

@implementation BarScannerViewController

- (id)init
{
    self = [super init];
    if (self) {
		// only enable code39
		[[self scanner] setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
		[[self scanner] setSymbology:ZBAR_CODE39 config:ZBAR_CFG_ENABLE to:1];
		
		// interface
		[self setShowsZBarControls:NO];
		
		CGRect cameraFrame = [[self view] frame];
		UIToolbar *bar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, cameraFrame.size.width, 44)] autorelease];
		[bar setBarStyle:UIBarStyleBlackTranslucent];
		[bar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissScanner)] autorelease];
		[bar setItems:[NSArray arrayWithObject:button]];
		[[self view] addSubview:bar];
		
		CGRect textFrame = CGRectMake(cameraFrame.size.width / 2 - 30, 5, cameraFrame.size.width / 2 + 30 - 10, 34);
		counter = [[UILabel alloc] initWithFrame:textFrame];
		[counter setTextAlignment:NSTextAlignmentRight];
		[counter setBackgroundColor:[UIColor clearColor]];
		[counter setTextColor:[UIColor whiteColor]];
		[counter setAdjustsFontSizeToFitWidth:YES];
		[counter setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[self updateCounter:0];
		[[self view] addSubview:counter];
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	[counter release];
	
	[super dealloc];
}

- (void)dismissScanner
{
	[readerDelegate imagePickerControllerDidCancel:(UIImagePickerController *)self];
}

- (void)updateCounter:(NSInteger)count
{
	NSString *text;
	if (count < 1) {
		text = @"Keine Tickets gescannt";
	} else {
		text = [NSString stringWithFormat:@"%i Tickets gescannt", count];
	}
	
	[counter setText:text];
}

@end
