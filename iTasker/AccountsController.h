//
//  AccountsController.h
//  iTasker
//
//  Created by Nurul Abser on 11/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "LoginModel.h"

@interface AccountsController : UIViewController
{
    Facebook *facebook;
    LoginModel *lm;
}
@property (nonatomic ,retain) Facebook *facebook;
@property (nonatomic,retain) LoginModel *lm;

- (IBAction)logout:(id)sender;

@end
