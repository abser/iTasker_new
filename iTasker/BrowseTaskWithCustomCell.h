//
//  BrowseTaskWithCustomCell.h
//  iTasker
//
//  Created by Nurul Abser on 7/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseTaskWithCustomCell : UIViewController <UITableViewDelegate ,UITableViewDataSource>
{
    UITableViewCell *taskCell;
}
-(id)getTaskList;
@property(nonatomic ,assign) IBOutlet UITableViewCell *taskCell;

@end
