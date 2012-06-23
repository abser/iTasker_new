//
//  PostTaskS2Controller.m
//  iTasker
//
//  Created by Nurul Abser on 28/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskS2Controller.h"
#import "PostTaskS3Controller.h"
#import "TaskPostModel.h"

@implementation PostTaskS2Controller
@synthesize fee;
@synthesize group1Val , group2Val;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    //NSUserDefaults *taskData = [NSUserDefaults standardUserDefaults];
    //NSString *test =  [taskData stringForKey:@"taskTitle"];
    
    //NSLog(@"receive data: %@",test);
    
    //self.fee.delegate = self;
    
    //Radio Button 1
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.tag = 1;
    [but1 setImage:[UIImage imageNamed:@"rb.png"] forState:UIControlStateNormal];
    [but1 setImage:[UIImage imageNamed:@"rb_selected.png"] forState:UIControlStateSelected];
    [but1 setFrame:CGRectMake(44, 238, 15, 15)];
    [but1 addTarget:self action:@selector(bGroup1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    //[but1 release];
    
    //Radio Button 2
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.tag = 2;
    [but2 setImage:[UIImage imageNamed:@"rb.png"] forState:UIControlStateNormal];
    [but2 setImage:[UIImage imageNamed:@"rb_selected.png"] forState:UIControlStateSelected];
    [but2 setFrame:CGRectMake(199, 238, 15, 15)];
    [but2 addTarget:self action:@selector(bGroup1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    //[but2 release];
    
    
    //Radio Button 3
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.tag = 3;
    [but3 setImage:[UIImage imageNamed:@"rb.png"] forState:UIControlStateNormal];
    [but3 setImage:[UIImage imageNamed:@"rb_selected.png"] forState:UIControlStateSelected];
    [but3 setFrame:CGRectMake(44, 307, 15, 15)];
    [but3 addTarget:self action:@selector(bGroup2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    //[but3 release];
    
    
    //Radio Button 4
    UIButton *but4 = [UIButton buttonWithType:UIButtonTypeCustom];
    but4.tag = 4;
    [but4 setImage:[UIImage imageNamed:@"rb.png"] forState:UIControlStateNormal];
    [but4 setImage:[UIImage imageNamed:@"rb_selected.png"] forState:UIControlStateSelected];
    [but4 setFrame:CGRectMake(199, 307, 15, 15)];
    [but4 addTarget:self action:@selector(bGroup2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but4];
    //[but4 release];
    
    self.fee.delegate = self;
    
    
    
    
}


- (IBAction)bGroup1Pressed:(UIButton *)button{
        
    [button setSelected:TRUE];
    UIButton *offBtn = (button.tag == 1) ? (UIButton *)[self.view viewWithTag:2] : (UIButton *)[self.view viewWithTag:1];
    
    [offBtn setSelected:NO];
    
    self.group1Val = (button.tag == 1) ? @"Cash" : @"Paypal";
    //NSLog(@"%@",group1Val);
}

- (IBAction)bGroup2Pressed:(UIButton *)button{
    
    [button setSelected:TRUE];
    UIButton *offBtn = (button.tag == 3) ? (UIButton *)[self.view viewWithTag:4] : (UIButton *)[self.view viewWithTag:3];
    
    [offBtn setSelected:NO];
    
    self.group2Val = (button.tag == 3) ? @"Fixed Price" : @"Hourly";
    
    //NSLog(@"%@",group2Val);
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidUnload
{
    [self setFee:nil];
    [self setGroup1Val:nil];
    [self setGroup2Val:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)GoToS3:(id)sender {
    NSUserDefaults *taskData = [NSUserDefaults standardUserDefaults];
    NSLog(@"1..");
    [taskData setObject:self.fee.text forKey:@"fee"];
    NSLog(@"set1: %@",self.fee.text);
    [taskData setObject:self.group1Val forKey:@"paymentMethod"];
    NSLog(@"set2: %@",self.group1Val);
    [taskData setObject:self.group2Val forKey:@"paymentType"];
   NSLog(@"set3: %@",self.group2Val);
    NSLog(@"2..");
    PostTaskS3Controller *ptS3 = [[PostTaskS3Controller alloc] initWithNibName:@"PostTaskS3View" bundle:nil];
    
    ptS3.title = @"Location";
    self.navigationItem.backBarButtonItem = nil;
    
    [self.navigationController pushViewController:ptS3 animated:NO];
    [ptS3 release];
}

-(void)dealloc
{
    [fee release];
    [group1Val release];
    [group2Val release];
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
