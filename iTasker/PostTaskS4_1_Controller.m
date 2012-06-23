//
//  PostTaskS4_1_Controller.m
//  iTasker
//
//  Created by Nurul Abser on 20/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskS4_1_Controller.h"

@implementation PostTaskS4_1_Controller

@synthesize datePicker = _datePicker;
@synthesize dateDM = _dateDM;
@synthesize dateDY = _dateDY;
@synthesize pickerToolBar;
@synthesize completeDate = _completeDate;



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
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterFullStyle;
    NSString *selDt = [NSString stringWithFormat:@"%@",
                       [df stringFromDate:[NSDate date]]];
    
    //self.dateDM.text= selDt;
    
    NSArray *splitDate = [selDt componentsSeparatedByString:@","];
    
    self.dateDM.text = [NSString stringWithFormat:@"%@",[splitDate objectAtIndex:1]];
    
    self.dateDY.text = [NSString stringWithFormat:@"%@, %@",[splitDate objectAtIndex:0],[splitDate objectAtIndex:2]];

    
    self.completeDate = [df dateFromString:[NSString stringWithFormat:@"%@",selDt]];    
    //NSLog(@"%@",d);
    
    //[selDt release];
    
    // Add Toolbar
    pickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    
    pickerToolBar.backgroundColor = [UIColor clearColor];
    pickerToolBar.opaque = NO;
    pickerToolBar.translucent = YES;
    
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyBoard:)] autorelease];
    
    [pickerToolBar setItems:[[[NSArray alloc] initWithObjects:doneButton,nil] autorelease]];
    
    _dateDM.inputAccessoryView = pickerToolBar;
    
    [pickerToolBar release];
    
    //Add Picker
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 220, 300, 260)];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    datePicker.date = [NSDate date];
    
    [datePicker addTarget:self action:@selector(changeLabel:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:datePicker];
    
    _dateDM.inputView = datePicker;
    
    
    

}


-(void)resignKeyBoard:(id)sender
{
    if([self.dateDM isFirstResponder])
    {
        [self.dateDM resignFirstResponder];
    }
}

- (void)viewDidUnload
{
    [self setDateDY:nil];
    [self setDateDM:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    //textField.inputAccessoryView = pickerToolBar;
    //textField.inputView = datePicker;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) dealloc
{
    [_dateDM release];

    [_dateDY release];
    [_datePicker release];
    [_completeDate release];
}


-(void)changeLabel:(id)sender
{
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    df.dateStyle = NSDateFormatterFullStyle;
    NSString *selDt = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:datePicker.date]];
    //self.dateDM.text= selDt;
    
    NSArray *splitDate = [selDt componentsSeparatedByString:@","];
    
    self.dateDM.text = [NSString stringWithFormat:@"%@",[splitDate objectAtIndex:1]];
    
    self.dateDY.text = [NSString stringWithFormat:@"%@, %@",[splitDate objectAtIndex:0],[splitDate objectAtIndex:2]];
    
    self.completeDate = [df dateFromString:[NSString stringWithFormat:@"%@",selDt]];  
    //[selDt release];
    //[splitDate release];

}

- (IBAction)doneAction:(id)sender
{
    datePicker.hidden = YES;
}
- (IBAction)postTask:(id)sender {
    
    // Retrive all data from user default.
    NSUserDefaults *taskData = [NSUserDefaults standardUserDefaults];
//    [taskData objectForKey:@"taskTitle"];
//    [taskData objectForKey:@"catId"];
//    [taskData objectForKey:@"taskDes"];
//    [taskData objectForKey:@"fee"];
//    [taskData objectForKey:@"paymentMethod"];
//    [taskData objectForKey:@"paymentType"];
//    [taskData objectForKey:@"streetNo"];
//    [taskData objectForKey:@"streetName"];
//    [taskData objectForKey:@"postCode"];
    
    
    // Post Data
    

    NSString *post = [NSString stringWithFormat:@"&task_name=%@&task_category_id=%@&description=%@&dead_line=%@&task_place=%@&street_no=%@&street_name=%@&zip_code=%@&amount=%@&payment_method=%@&payment_type=%@&post_byuid=%@&repeat_task=%@&repeat_in=%@&repeat_day",
                      [taskData objectForKey:@"taskTitle"],
                      [taskData objectForKey:@"catId"],
                      [taskData objectForKey:@"taskDes"],
                      self.completeDate,
                      @"",
                      [taskData objectForKey:@"streetNo"],
                      [taskData objectForKey:@"streetName"],
                      [taskData objectForKey:@"postCode"],
                      [taskData objectForKey:@"fee"],
                      [taskData objectForKey:@"paymentMethod"],
                      [taskData objectForKey:@"paymentType"],
                      @"",
                      @"",
                      @"",
                      @""
                      ];
    NSLog(@"Post data: %@",post);
    
    // ENCODE THE STRING AS DATA
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    // CALCUATE THE STRIN LENGTH
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    //CREATE URL REQUEST 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //SET URL
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/post/itmoapp/"]]];
    
    // SET POST METHOD
    [request setHTTPMethod:@"POST"];
    
    //HEADER
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    //NOW CONNECT
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]autorelease];
    
    NSLog(@"%@",returnString);
    
    //[taskData release];

}
@end
