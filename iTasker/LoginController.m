//
//  LoginController.m
//  iTasker
//
//  Created by Nurul Abser on 29/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "LoginController.h"
#import "RegistrationController.h"
#import "LoginModel.h"

@implementation LoginController
@synthesize email;
@synthesize password;
@synthesize facebook;

static NSString *FB_ID = @"300862099993835";


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
    email.delegate = self;
    password.delegate = self;
    
}

- (void)viewDidUnload
{
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)CreateAccount:(id)sender {
    
    RegistrationController *regC = [[RegistrationController alloc] initWithNibName:@"RegistrationView" bundle:nil];
    
    //regC.title = @"iTasker Registration";
    NSLog(@"Calling Reg");
    self.navigationItem.backBarButtonItem = nil;
    NSLog(@"Nav Obj: %@",self.navigationController);
    [self.navigationController pushViewController:regC animated:YES];
    [regC release];
   
}

- (IBAction)login:(id)sender {
   
   if(email.text != NULL && password.text != NULL)
   {
    
    // POST DATA STRING
    NSString *post = [NSString stringWithFormat:@"&user_email=%@&password=%@",[email text] ,[password text]];
    
    // ENCODE THE STRING AS DATA
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    // CALCUATE THE STRIN LENGTH
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    //CREATE URL REQUEST 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //SET URL
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/login/itmoapp"]]];
    
    // SET POST METHOD
    [request setHTTPMethod:@"POST"];
    
    //HEADER
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    //NOW CONNECT
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"Response: %@",returnString);
       
       if([returnString isEqualToString:@"NOK"])
       {
           // show error
           UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 20)];
           label.text = @"Wrong User Name or Password";
           label.backgroundColor = [UIColor redColor];
           [self.view addSubview:label];
           [label release];
           
           // SHOW ALERT
           UIAlertView *alert =
           [[UIAlertView alloc] initWithTitle:@"Login Failed!"
                                      message:@"Wrong user id or password!"
                                     delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
           [alert show];
           [alert release];
           
           
       }
       else
       {
           // else save return session key
           [LoginModel saveLoginData:email.text pass:password.text sessionKey:returnString];
           //[LoginModel getLoginData];
           //dismiss login view
           NSLog(@" Login Data saved in key store..");
           [self dismissModalViewControllerAnimated:TRUE];
           
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

- (IBAction)loginWithFb:(id)sender {
    
   facebook = [[Facebook alloc] initWithAppId:FB_ID andDelegate:self]; 
    
   // facebook = [[Facebook alloc] initWithAppId:@"289622131103120" andDelegate:self];
    
    // Check Previous session
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    // Check Session validity
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    }
    
}


// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}


//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [[controller facebook] handleOpenURL:url];
//}


- (void)fbDidLogin {
    NSLog(@"Comes Here!");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    NSLog(@"Access Token: %@",[facebook accessToken]);
    [self dismissModalViewControllerAnimated:TRUE];
    
}


-(void) fbDidNotLogin:(BOOL)cancelled
{
if(cancelled == TRUE)
{
    NSLog(@"user reject login!");
}
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
}


- (void)fbDidLogout
{
}
- (void)fbSessionInvalidated
{
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [email release];
    [password release];
    [super dealloc];
}
@end
