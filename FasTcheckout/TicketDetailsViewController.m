//
//  TicketDetailsViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "TicketDetailsViewController.h"
#import "Ticket.h"

@interface TicketDetailsViewController ()

- (void)reloadData;

@end

@implementation TicketDetailsViewController

@synthesize tableView;

- (id)initWithTicket:(Ticket *)t
{
	self = [super initWithNibName:nil bundle:nil];
	if (self) {
		[[self navigationItem] setTitle:@"Ticket"];
		
		ticket = [t retain];
		
		[self reloadData];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
	ticket = nil;
	
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)dealloc {
    [tableView release];
	[ticket release];
	
    [super dealloc];
}

#pragma mark private methods

- (void)reloadData
{
	[tableView reloadData];
}

#pragma mark table data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

@end
