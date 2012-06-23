//
//  FirstViewController.h
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@interface BrowseTaskController : UIViewController <UITableViewDelegate , UITableViewDataSource>

{
    UITableViewCell *taskCell;
}

@property(nonatomic ,assign) IBOutlet UITableViewCell *taskCell;
-(id)getTaskList;
@end
