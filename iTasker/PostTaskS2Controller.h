//
//  PostTaskS2Controller.h
//  iTasker
//
//  Created by Nurul Abser on 28/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTaskS2Controller : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *fee;
@property (retain , nonatomic) NSString *group1Val;
@property (retain , nonatomic) NSString *group2Val;

- (IBAction)GoToS3:(id)sender;

@end
