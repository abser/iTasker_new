//
//  LoginController.h
//  iTasker
//
//  Created by Nurul Abser on 29/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface LoginController : UIViewController<UITextFieldDelegate,FBSessionDelegate>
{
    Facebook *facebook;
}
@property (nonatomic , retain) Facebook *facebook;
@property (retain, nonatomic) IBOutlet UITextField *email;
@property (retain, nonatomic) IBOutlet UITextField *password;


- (IBAction)CreateAccount:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)loginWithFb:(id)sender;

@end
