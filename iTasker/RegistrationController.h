//
//  RegistrationController.h
//  iTasker
//
//  Created by Nurul Abser on 29/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationController : UIViewController<UITextFieldDelegate>
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;
@property (retain, nonatomic) IBOutlet UITextField *firstName;
@property (retain, nonatomic) IBOutlet UITextField *lastName;
@property (retain, nonatomic) IBOutlet UITextField *email;
@property (retain, nonatomic) IBOutlet UITextField *contactNo;
@property (retain, nonatomic) IBOutlet UITextField *postCode;
@property (retain, nonatomic) IBOutlet UITextField *city;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UITextField *retypePass;
- (IBAction)register:(id)sender;

@end
