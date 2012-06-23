//
//  PostTaskController.h
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTaskController : UIViewController
- (void)showPostTask:(NSString *)category;
- (IBAction)PostHW:(id)sender;
- (IBAction)PostDelivery:(id)sender;
- (IBAction)PostCleaning:(id)sender;
- (IBAction)PostIkea:(id)sender;
- (IBAction)PostOfficeAdmin:(id)sender;

- (IBAction)PostShopping:(id)sender;
- (IBAction)PostComputer:(id)sender;
- (IBAction)PostCarWash:(id)sender;
- (IBAction)PostFood:(id)sender;
- (IBAction)PostSurvey:(id)sender;
- (IBAction)PostDisposal:(id)sender;
- (IBAction)PostSE:(id)sender;

@end
