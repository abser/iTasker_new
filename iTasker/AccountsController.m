//
//  AccountsController.m
//  iTasker
//
//  Created by Nurul Abser on 11/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "AccountsController.h"
#import "LoginModel.h"


@implementation AccountsController
@synthesize facebook;
@synthesize lm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Accounts", @"Accounts");
        self.tabBarItem.image = [UIImage imageNamed:@"accounts"];
        
        lm = [[LoginModel alloc]init];
        facebook = [[Facebook alloc]initWithAppId:@"300862099993835" andDelegate:lm];
    }
    return self;
}
-(void) dealloc
{
    [facebook release];
    [lm release];
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

- (IBAction)logout:(id)sender {
        [facebook logout];
    NSLog(@"user loged out");
    [LoginModel logout];
    LoginController *lc = [[LoginController alloc]initWithNibName:@"LoginView" bundle:nil];
    UINavigationController *loginNav = [[[UINavigationController alloc] initWithRootViewController:lc] autorelease];
    
    //[self.tabBarController pushViewController:lc animated:YES];
    [self.tabBarController presentModalViewController:loginNav animated:YES];
    [loginNav release];
}


@end
