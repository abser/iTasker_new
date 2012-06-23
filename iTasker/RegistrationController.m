//
//  RegistrationController.m
//  iTasker
//
//  Created by Nurul Abser on 29/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "RegistrationController.h"
#import "LoginController.h"

@implementation RegistrationController
@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize contactNo;
@synthesize postCode;
@synthesize city;
@synthesize password;
@synthesize retypePass;

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
    firstName.delegate =self;
    lastName.delegate = self;
    email.delegate = self;
    contactNo.delegate = self;
    postCode.delegate = self;
    city.delegate = self;
    password.delegate = self;
    retypePass.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidUnload
{
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setContactNo:nil];
    [self setPostCode:nil];
    [self setCity:nil];
    [self setPassword:nil];
    [self setRetypePass:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//SOME TWWEK TO SLIDE UP TEXT FILED WHEN EDITING

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)dealloc {
    [firstName release];
    [lastName release];
    [email release];
    [contactNo release];
    [postCode release];
    [city release];
    [password release];
    [retypePass release];
    [super dealloc];
}
- (IBAction)register:(id)sender {
    
    if(email.text != NULL && password.text != NULL)
    {
        
        // POST DATA STRING
        NSString *post = [NSString stringWithFormat:@"&first_name=%@&last_name=%@&city=%@&email=%@&contact_no=%@&zipcode=%@&password=%@&repassword=%@",[firstName text] ,[lastName text],[city text],[email text],[contactNo text],[postCode text],[password text],[retypePass text]];
        NSLog(@"Post data: %@",post);
        // ENCODE THE STRING AS DATA
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        // CALCUATE THE STRIN LENGTH
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        
        //CREATE URL REQUEST 
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //SET URL
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/signup/itmoapp"]]];
        
        // SET POST METHOD
        [request setHTTPMethod:@"POST"];
        
        //HEADER
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPBody:postData];
        
        //NOW CONNECT
        NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]autorelease];
        
        NSLog(@"Response: %@",returnString);
        
        if([returnString isEqualToString:@""])
        {
                    
            // SHOW ALERT
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Registration Failed!"
                                       message:@"Please check the data!"
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
        }
        else
        {
           // Go to Login page
            LoginController *lc = [[LoginController alloc]init];
            [self.modalViewController presentModalViewController:lc animated:NO];
            [lc release];
            
        }
        
    }
    else
    {
        // SHOW ALERT
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"No Input!"
                                   message:@"Please give your User Id and Password"
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    

}
@end
