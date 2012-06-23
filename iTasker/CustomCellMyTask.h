//
//  CustomCellMyTask.h
//  iTasker
//
//  Created by Nurul Abser on 13/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellMyTask : UITableViewCell
{
    UILabel *primaryLabel;   
   
    UILabel *secondaryLabel;   
   
    UIImageView *myImageView;
    UIImageView *clouserIcon;
    
}

@property (nonatomic , retain) UILabel *primaryLabel;
@property (nonatomic , retain) UILabel *secondaryLabel;
@property(nonatomic,retain) UIImageView *myImageView;  
@property (nonatomic , retain) UIImageView *clouserIcon;
@end
