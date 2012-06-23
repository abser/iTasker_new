//
//  PostTaskS4Controller.m
//  iTasker
//
//  Created by Nurul Abser on 10/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskS4Controller.h"
#import "PostTaskS4_1_Controller.h"

@implementation PostTaskS4Controller

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

- (IBAction)goToDeadline:(id)sender {
    PostTaskS4_1_Controller *ptS4_1 = [[PostTaskS4_1_Controller alloc] initWithNibName:@"PostTaskS4_1_View" bundle:nil];
    
    ptS4_1.title = @"Deadline";
    self.navigationItem.backBarButtonItem = nil;
    
    [self.navigationController pushViewController:ptS4_1
 animated:NO];
}

- (IBAction)repeatTask:(id)sender {
}
@end
