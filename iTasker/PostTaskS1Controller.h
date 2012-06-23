//
//  PostTaskS1Controller.h
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTaskS1Controller : UIViewController<UITextFieldDelegate,UITextViewDelegate, UIPickerViewDelegate , UIPickerViewDataSource>
{
    UIPickerView *picker;
    NSString *selCatID;
    UIToolbar *keyboardToolbar;
}
@property (retain, nonatomic) IBOutlet UITextField *taskTitle;
@property (retain, nonatomic) IBOutlet UITextField *category;
@property (retain, nonatomic) IBOutlet UITextView *description;
- (IBAction)showCatPicker:(id)sender;

- (IBAction)GoS2:(id)sender;

-(NSArray *) getAndSetCategoryList;


@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic ,retain) NSMutableArray *catList;
@property (nonatomic ,retain) NSMutableArray *catListId;
@property (nonatomic , retain) UIToolbar *keyboardToolbar;

-(void)setViewMovedUp:(BOOL)movedUp;

@end
