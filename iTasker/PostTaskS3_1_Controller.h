//
//  PostTaskS3_1_Controller.h
//  iTasker
//
//  Created by Nurul Abser on 20/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTaskS3_1_Controller : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *streetNo;
@property (retain, nonatomic) IBOutlet UITextField *streetName;

@property (retain, nonatomic) IBOutlet UITextField *postCode;
- (IBAction)goToS4:(id)sender;
-(void)setViewMovedUp:(BOOL)movedUp;
@end
