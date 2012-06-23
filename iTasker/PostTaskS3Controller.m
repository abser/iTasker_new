//
//  PostTaskS3Controller.m
//  iTasker
//
//  Created by Nurul Abser on 28/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskS3Controller.h"
#import "PostTaskS3_1_Controller.h"
#import "PostTaskS4Controller.h"

@implementation PostTaskS3Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onlinetask:(id)sender {
    PostTaskS4Controller *ptS4 = [[PostTaskS4Controller alloc] initWithNibName:@"PostTaskS4View" bundle:nil];
    
    ptS4.title = @"Deadline";
    self.navigationItem.backBarButtonItem = nil;
    
    [self.navigationController pushViewController:ptS4 animated:NO];
    [ptS4 release];
}

- (IBAction)goToPlace:(id)sender {
    PostTaskS3_1_Controller *ptS3_1 = [[PostTaskS3_1_Controller alloc] initWithNibName:@"PostTaskS3_1_View" bundle:nil];
    
    ptS3_1.title = @"Location";
    self.navigationItem.backBarButtonItem = nil;
    
    [self.navigationController pushViewController:ptS3_1 animated:NO];
    [ptS3_1 release];
}

@end
