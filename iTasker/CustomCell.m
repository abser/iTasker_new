//
//  CustomCell.m
//  iTasker
//
//  Created by Nurul Abser on 5/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
{
    UIImageView *sep;
}
@synthesize userImage, primaryLabel, statusLabel ,userStatusIcon, bidAmountLabel,disclouserIcon, taskPostTime;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        userImage = [[UIImageView alloc]init];
        
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont boldSystemFontOfSize:14];
        primaryLabel.backgroundColor = [UIColor clearColor];
        
        statusLabel = [[UILabel alloc]init];
        statusLabel.textAlignment = UITextAlignmentCenter;
        statusLabel.font = [UIFont boldSystemFontOfSize:10];
        statusLabel.backgroundColor = [UIColor colorWithRed:0.725 green:0.894 blue:0.941 alpha:1.0];
        statusLabel.textColor = [UIColor whiteColor];
        
        userStatusIcon = [[UIImageView alloc]init];
        
        bidAmountLabel = [[UILabel alloc]init];
        bidAmountLabel.textAlignment = UITextAlignmentRight;
        bidAmountLabel.font = [UIFont systemFontOfSize:15];
        bidAmountLabel.backgroundColor = [UIColor clearColor];
        bidAmountLabel.textColor = [UIColor orangeColor];
        
        disclouserIcon = [[UIImageView alloc]init];
        disclouserIcon.image = [UIImage imageNamed:@"cell_disclouser"];
        disclouserIcon.backgroundColor = [UIColor clearColor];
        
        taskPostTime = [[UILabel alloc]init];
        taskPostTime.textAlignment = UITextAlignmentRight;
        taskPostTime.font = [UIFont systemFontOfSize:10];
        taskPostTime.textColor = [UIColor grayColor];
        taskPostTime.backgroundColor = [UIColor clearColor];
        
        sep = [[UIImageView alloc]init];
        sep.image = [UIImage imageNamed:@"cell_sep"];
        sep.backgroundColor = [UIColor clearColor];

        
       
        

        
        [self.contentView addSubview:userImage];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:statusLabel];
        [self.contentView addSubview:userStatusIcon];
        [self.contentView addSubview:bidAmountLabel];
        [self.contentView addSubview:disclouserIcon];
        [self.contentView addSubview:taskPostTime];  
        [self.contentView addSubview:sep]; 

        

        
        //self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
        
        
    }
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentRect =   self.contentView.bounds;
    CGFloat boundX = contentRect.origin.x;
    
    CGRect frame;
    frame = CGRectMake(boundX+10, 10, 50, 50);

    userImage.frame = frame;
    
    frame = CGRectMake(boundX+70, 10, 200, 15);
    primaryLabel.frame = frame;
    
    frame = CGRectMake(boundX+70, 40, 80, 15);
    statusLabel.frame = frame;
    
    frame = CGRectMake(boundX+70, 60, 38, 12);
    userStatusIcon.frame = frame;
    
    frame = CGRectMake(boundX+200, 40, 100, 15);
    bidAmountLabel.frame = frame;
    
    frame = CGRectMake(boundX+300, 40, 15, 15);
    disclouserIcon.frame = frame;
    
    frame = CGRectMake(boundX+200, 65, 100, 15);
    taskPostTime.frame = frame;
    
    frame = CGRectMake(boundX+0, 85, 320, 1);
    sep.frame = frame;
    
        
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
