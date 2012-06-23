//
//  TaskDetailsController.h
//  iTasker
//
//  Created by Nurul Abser on 4/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface TaskDetailsController : UIViewController
{
    UILabel *taskTitle;
    IBOutlet UIScrollView *pageScroller;
}
@property (retain, nonatomic) IBOutlet UILabel *taskTitle;
@property (nonatomic , retain) NSString *selTitle;

@property (retain, nonatomic) IBOutlet UILabel *taskBudget;
@property (nonatomic , retain) NSString *selBugdest;

@property (retain, nonatomic) IBOutlet UILabel *taskStatus;
@property (nonatomic , retain) NSString *selStatus;
@property (retain, nonatomic) IBOutlet UITableViewCell *descriptionCell;

@property (retain, nonatomic) IBOutlet UITextView *taskDescription;
@property (nonatomic , retain) NSString *selDes;

@end
