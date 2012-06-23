//
//  TaskDetailsController.m
//  iTasker
//
//  Created by Nurul Abser on 4/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "TaskDetailsController.h"

@implementation TaskDetailsController
@synthesize descriptionCell;

@synthesize taskTitle , selTitle , taskBudget , selBugdest ,taskStatus , selStatus ,taskDescription ,selDes;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [pageScroller setScrollEnabled:YES];
    [pageScroller setContentSize:CGSizeMake(320,800)];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"title: %@",selTitle);
    taskTitle.text = selTitle;
    taskBudget.text = [NSString stringWithFormat:@"$%@", selBugdest];
    taskStatus.font = [UIFont boldSystemFontOfSize:9];
    taskStatus.layer.cornerRadius = 3;
    taskStatus.text = ([selStatus isEqualToString:@"1"]) ? @"Open for bid" : @"Task closed";
    
    descriptionCell.layer.borderWidth = 1.0f;
    descriptionCell.layer.borderColor = [[UIColor orangeColor] CGColor];
    descriptionCell.layer.cornerRadius = 8;
    taskDescription.text = selDes;
    
   
}

- (void)viewDidUnload
{
    
    //[self setTaskTitle:nil];
    //[self setTaskBudget:nil];
    [self setTaskDescription:nil];
    [self setTaskStatus:nil];
    [self setDescriptionCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [taskTitle release];
    [taskBudget release];
    [taskDescription release];
    [taskStatus release];
    [selTitle release];
    [selBugdest release];
    [selStatus release];
    [selDes release];
    [descriptionCell release];
    [super dealloc];
}
@end
