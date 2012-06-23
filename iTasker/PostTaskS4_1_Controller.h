//
//  PostTaskS4_1_Controller.h
//  iTasker
//
//  Created by Nurul Abser on 20/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTaskS4_1_Controller : UIViewController<UITextFieldDelegate>
{
    UIDatePicker *datePicker;
    UIToolbar *pickerToolBar;

}
@property (nonatomic , retain) UIDatePicker *datePicker;
@property (nonatomic,retain) IBOutlet UITextField *dateDM;
@property (retain, nonatomic) IBOutlet UILabel *dateDY;

@property (nonatomic, retain) UIToolbar *pickerToolBar;
@property (nonatomic , retain) NSDate *completeDate;

- (IBAction)postTask:(id)sender;

@end
