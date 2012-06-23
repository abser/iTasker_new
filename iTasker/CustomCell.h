//
//  CustomCell.h
//  iTasker
//
//  Created by Nurul Abser on 5/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    UIImageView *userImage;
    UILabel *primaryLabel;   
    UILabel *statusLabel;
    UIImageView *userStatusIcon;   
    UILabel *bidAmountLabel;
    UIImageView *disclouserIcon;
    UILabel *taskPostTime;
    
}

@property(nonatomic,retain) UIImageView *userImage;
@property (nonatomic , retain) UILabel *primaryLabel;
@property (nonatomic , retain) UILabel *statusLabel;
@property(nonatomic,retain) UIImageView *userStatusIcon;
@property (nonatomic , retain) UILabel *bidAmountLabel;
@property(nonatomic,retain) UIImageView *disclouserIcon;
@property (nonatomic , retain) UILabel *taskPostTime;
@end
