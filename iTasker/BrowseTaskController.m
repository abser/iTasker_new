//
//  FirstViewController.m
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "BrowseTaskController.h"
#import "CustomCell.h"
//#import "ListTaskModel.h"
#import "TaskDetailsController.h"

@implementation BrowseTaskController
{
    
    NSMutableArray *taskTitle;
    NSMutableArray *taskDes;
    NSMutableArray *taskPhoto;    
    NSMutableArray *bidAmount;
    NSMutableArray *taskStatus;
    NSMutableArray *taskLifeTime;
    
    NSString *lifeTime;
     
}
@synthesize taskCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Browse Task", @"Browse Task");
        self.tabBarItem.image = [UIImage imageNamed:@"browse"];
        
        
    }
    return self;
}
							
-(void) dealloc
{
    [taskTitle release];
    [taskDes release];
    [taskPhoto release];
    [bidAmount release];
    [taskCell release];
    [taskStatus release];
    [taskLifeTime release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    taskTitle   = [[NSMutableArray alloc]init];
    taskDes     = [[NSMutableArray alloc]init];    
    taskPhoto   = [[NSMutableArray alloc]init];
    bidAmount   = [[NSMutableArray alloc]init];
    taskStatus  = [[NSMutableArray alloc]init];
    taskLifeTime  = [[NSMutableArray alloc]init];
    
    [self getTaskList];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [tableView reloadData];    
    
    self.view = tableView;
    //[taskList release];
    [tableView release];
	
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Count : %d",[taskTitle count]);
    return [taskTitle count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
return @"Task List All";
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellIdentifier = @"taskCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        
    }
    //NSData *imgData = [NSData dataWithContentsOfURL:[taskPhoto objectAtIndex:indexPath.row]];    
    //cell.imageView.image = [UIImage imageWithData:imgData];  
    
    cell.userImage.image = [UIImage imageNamed:@"blank"];
    cell.primaryLabel.text = [taskTitle objectAtIndex:indexPath.row];
    cell.statusLabel.text = ([[taskStatus objectAtIndex:indexPath.row] isEqualToString:@"1"]) ? @"Open for Bid" : @"Closed";  
    cell.userStatusIcon.image = [UIImage imageNamed:@"online"];
    cell.bidAmountLabel.text = [NSString stringWithFormat:@"$%@",[bidAmount objectAtIndex:indexPath.row]];
    
    cell.taskPostTime.text = [taskLifeTime objectAtIndex:indexPath.row];
    
    
    return cell;
}




-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TaskDetailsController *tdc = [[TaskDetailsController alloc] initWithNibName:@"TaskDetailsView" bundle:nil];
    
    tdc.title = @"Task Details";
    
    tdc.selTitle    = [taskTitle objectAtIndex:indexPath.row];
    tdc.selBugdest  = [bidAmount objectAtIndex:indexPath.row];    
    tdc.selStatus   = [taskStatus objectAtIndex:indexPath.row];    
    tdc.selDes      = [taskDes objectAtIndex:indexPath.row];
    
    [[self navigationController] pushViewController:tdc animated:YES];
    [tdc release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(id)getTaskList
{
    // SBJSON *parser = [[SBJSON alloc]init];
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/test/page1.php?action=getTask"]];
    
    //NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSString *urlstring =  [NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/getalltask/itmoapp"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",jsonString);
    
    NSDictionary *results = [jsonString JSONValue];
    //NSLog(@"%@",results);
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for(NSDictionary *result in results)
    {
        NSString *title = [result objectForKey:@"task_name"];     
        NSString *des = [result objectForKey:@"description"];        
        //NSString *photo = [result objectForKey:@"image"]; 
        NSString *amount = [result objectForKey:@"amount"];
        NSString *status = [result objectForKey:@"status"];
        NSString *postDate_ = [result objectForKey:@"post_date"]; 
        //NSLog(@"Post date: %@",postDate_);
        NSString *postTime_ = [result objectForKey:@"post_time"];
        //NSLog(@"Post time: %@",postTime_);
        NSDate *postDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",postDate_ ,postTime_]];
        if(postDate != NULL)
        {
        NSDate * today = [NSDate date];
        NSLog(@"Today: %@",today);
        NSLog(@"Task date: %@",postDate);
        
        NSTimeInterval distanceBetweenDates = [today timeIntervalSinceDate:postDate];
        NSLog(@"Time Interval: %f",distanceBetweenDates);
        double secondsInAnHour = 3600;
        NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
        NSInteger days =  abs(hoursBetweenDates / 24);
        NSInteger hours = abs(hoursBetweenDates % 24);
        NSLog(@"%d Days %d Hours",days,hours);
        
        lifeTime = [NSString stringWithFormat:@"%d days %d hours ago",days,hours]; 
            
        }
        else
        {
        lifeTime = @"0 hours ago";
        }
        //NSLog(@"Title:%@ Des: %@",title,des);
        
        [taskTitle addObject:title];
        [taskDes addObject:des];
        //[taskPhoto addObject: [NSURL URLWithString:photo]];
        [bidAmount addObject:amount];
        [taskStatus addObject:status];
        [taskLifeTime addObject:lifeTime];
        
        
    }
    
    NSLog(@"No of Title: %d",[taskTitle count]);
    return self;
    
    
}

@end
