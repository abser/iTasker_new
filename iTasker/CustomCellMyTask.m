//
//  CustomCellMyTask.m
//  iTasker
//
//  Created by Nurul Abser on 13/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "CustomCellMyTask.h"

@implementation CustomCellMyTask
{
    UIImageView *sep;
}

@synthesize primaryLabel, secondaryLabel , myImageView ,clouserIcon;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:14];
        primaryLabel.backgroundColor = [UIColor clearColor];
        
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = UITextAlignmentLeft;
        secondaryLabel.font = [UIFont systemFontOfSize:8];
        secondaryLabel.backgroundColor = [UIColor clearColor];
               
        myImageView = [[UIImageView alloc]init];
        
        clouserIcon = [[UIImageView alloc]init];
        clouserIcon.image = [UIImage imageNamed:@"cell_disclouser"];
        
        sep = [[UIImageView alloc]init];
        sep.image = [UIImage imageNamed:@"cell_sep"];
        sep.backgroundColor = [UIColor clearColor];

        
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:myImageView];
        [self.contentView addSubview:clouserIcon];
        [self.contentView addSubview:sep]; 
        
        
        
        //self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
        
        
    }
    return self;
}


//-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
//    {
//    primaryLabel = [[UILabel alloc]init];
//    primaryLabel.textAlignment = UITextAlignmentLeft;
//    primaryLabel.font = [UIFont systemFontOfSize:14];
//    
//    secondaryLabel = [[UILabel alloc]init];
//    secondaryLabel.textAlignment = UITextAlignmentLeft;
//    secondaryLabel.font = [UIFont systemFontOfSize:8];
//    
//    myImageView = [[UIImageView alloc]init];
//    
//    [self.contentView addSubview:primaryLabel];
//    [self.contentView addSubview:secondaryLabel];
//    [self.contentView addSubview:myImageView];
//    }
//    return self;
//
//}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentRect =   self.contentView.bounds;
    CGFloat boundX = contentRect.origin.x;
    
    CGRect frame;
    frame = CGRectMake(boundX+10, 5, 50, 50);
    
    myImageView.frame = frame;
    
    frame = CGRectMake(boundX+70, 5, 200, 25);
    primaryLabel.frame = frame;

    
    frame = CGRectMake(boundX+70, 30, 100, 15);
    secondaryLabel.frame = frame;
    
    frame = CGRectMake(boundX+300, 15, 15, 15);
    clouserIcon.frame = frame;
    
    frame = CGRectMake(boundX+0, 60, 320, 1);
    sep.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
