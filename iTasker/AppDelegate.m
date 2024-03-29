//
//  AppDelegate.m
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "AppDelegate.h"
//#import "FirstPageController.h"
#import "LoginController.h"
#import "BrowseTaskController.h"
//#import "BrowseTaskWithCustomCell.h"
#import "PostTaskController.h"
#import "WatchTaskcontroller.h"
#import "TaskPosterMessageController.h"
#import "AccountsController.h"
#import "LoginModel.h"

static NSString* APP_ID = @"300862099993835";


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize facebook;


- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [facebook release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
     LoginController *loginController = [[[LoginController alloc]initWithNibName:@"LoginView" bundle:nil] autorelease];
    facebook =  [[Facebook alloc]initWithAppId:APP_ID andDelegate:loginController];


    //POST TASK CONTROLLER   
    UIViewController *postTaskController = [[[PostTaskController alloc] initWithNibName:@"PostTaskView" bundle:nil] autorelease];
    
    UINavigationController *postTaskNavController = [[[UINavigationController alloc] initWithRootViewController:postTaskController] autorelease];
    
    //postTaskNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    // WATCH TASK CONTROLLER
     UIViewController *watchTaskController = [[[WatchTaskcontroller alloc] initWithNibName:@"WatchTaskView" bundle:nil] autorelease];
    
    UINavigationController *watchTaskNavController = [[[UINavigationController alloc] initWithRootViewController:watchTaskController] autorelease];
    
    //watchTaskNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    // BROWSE TASK CONTROLL
    UIViewController *browseTaskController = [[[BrowseTaskController alloc] initWithNibName:@"BrowseTaskView" bundle:nil] autorelease];
    
    
    
    UINavigationController *browseTaskNavController = [[[UINavigationController alloc] initWithRootViewController:browseTaskController] autorelease];
    
    //browseTaskNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    //MESSAGE CONTROLLER
    UIViewController *taskPosterMessageController = [[[TaskPosterMessageController alloc] initWithNibName:@"TaskPosterMessageView" bundle:nil] autorelease];
    
    //ACCOUNT CONTROLLER
    UIViewController *accountsController = [[[AccountsController alloc]initWithNibName:@"AccountsView" bundle:nil] autorelease];
    
    UINavigationController *accountNavController = [[[UINavigationController alloc] initWithRootViewController:accountsController] autorelease];
    
    //accountNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    // INITILIZE AND ADDITING TO TAB BAR CONTROLLER
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:watchTaskNavController, postTaskNavController, browseTaskNavController , taskPosterMessageController, accountNavController, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    /* Present next run loop. Prevents "unbalanced VC display" warnings. */
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
     
             
    //CHECK KEYCHAIN FOR LOGIN DATA
    NSArray *loginData = [LoginModel getLoginData];
    if([[loginData objectAtIndex:0] isEqualToString:@""])
    {
    // Check for facebook token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] 
            && [defaults objectForKey:@"FBExpirationDateKey"]) 
        {
            NSLog(@"Previous FB Token Found!");
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        // Check for valid session
            if (![facebook isSessionValid]) 
            {
                [self showLoginPage];
                NSLog(@"Not a Valid session!");
                //[facebook authorize:nil];
            }

            }
            else
            {
                // Facebook login data not found
                NSLog(@"No FB Token found!");
            [self showLoginPage];
            }
            
        }
        else
        {
        //LOGIN USER TO THE SERVER
         NSString *response =   [LoginModel sendLoginToServer:[loginData objectAtIndex:0] pass:[loginData objectAtIndex:1]];
            //DECIDE ON LOGIN RESPONSE
            if([response isEqualToString:@"NOK"])
            {
                [self showLoginPage];
            }
            else
            {
                
            }
            
        }
    
        
        
    });

    return YES;
}

- (void) showLoginPage
{
    //SHWO LOGIN PAGE
    LoginController *loginController = [[[LoginController alloc]initWithNibName:@"LoginView" bundle:nil] autorelease];
    
    loginController.title = @"iTasker Login";
    UINavigationController *loginNav = [[[UINavigationController alloc] initWithRootViewController:loginController] autorelease];
    
    
    [self.tabBarController presentModalViewController:loginNav animated:YES];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //[[self facebook] extendAccessTokenIfNeeded];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}


@end
