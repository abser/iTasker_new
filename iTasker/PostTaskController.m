//
//  PostTaskController.m
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskController.h"
#import "PostTaskS1Controller.h"

@implementation PostTaskController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Post Task", @"Post Task");
        self.tabBarItem.image = [UIImage imageNamed:@"post"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)PostHW:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostDelivery:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostCleaning:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostIkea:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostOfficeAdmin:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostShopping:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostComputer:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostCarWash:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostFood:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostSurvey:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostDisposal:(id)sender {
    [self showPostTask:@"Details"];
}

- (IBAction)PostSE:(id)sender {
    [self showPostTask:@"Details"];
}


- (void)showPostTask:(NSString *)category
{
    PostTaskS1Controller *ptS1 = [[[PostTaskS1Controller alloc] initWithNibName:@"PostTaskS1View" bundle:nil] autorelease];
    
    ptS1.title =[NSString stringWithFormat: @"%@",category];
    self.navigationItem.backBarButtonItem = nil; 
    self.navigationItem.backBarButtonItem.tintColor = [UIColor redColor];
    //CUSTOMIZING NAVIGATION BACK BUTTON LOOK.
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Custom" style:UIBarButtonItemStylePlain target:self action:nil];
  
    //backButton.image = [UIImage imageNamed:@"back_btn.png"];
    //self.navigationItem.backBarButtonItem = backButton;
    
    ptS1.hidesBottomBarWhenPushed = YES;
       
    [self.navigationController pushViewController:ptS1 animated:NO];
}
- (void)dealloc {
    
    [super dealloc];
}
@end
