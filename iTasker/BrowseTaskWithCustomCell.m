//
//  BrowseTaskWithCustomCell.m
//  iTasker
//
//  Created by Nurul Abser on 7/6/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "BrowseTaskWithCustomCell.h"
#import "JSON.h"

@implementation BrowseTaskWithCustomCell
{
    NSMutableArray *taskTitle;
    NSMutableArray *taskDes;
    NSMutableArray *taskPhoto;
}
@synthesize taskCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Browse Task", @"Browse Task");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    taskTitle   = [[NSMutableArray alloc]init];
    taskDes     = [[NSMutableArray alloc]init];    
    taskPhoto   = [[NSMutableArray alloc]init];
    
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


-(id)getTaskList
{
    // SBJSON *parser = [[SBJSON alloc]init];
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/test/page1.php?action=getTask"]];
    
    //NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSString *urlstring =  [NSString stringWithFormat:@"http://localhost/test/page1.php?action=getTask"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",jsonString);
    
    NSDictionary *results = [jsonString JSONValue];
    NSLog(@"%@",results);
    
    for(NSDictionary *result in results)
    {
        NSString *title = [result objectForKey:@"task_title"];     
        NSString *des = [result objectForKey:@"task_des"];        
        NSString *photo = [result objectForKey:@"image"];         
        // CGFloat *amount = [result objectForKey:@"amount"]; 
        NSLog(@"Title:%@ Des: %@",title,des);
        
        [taskTitle addObject:title];
        [taskDes addObject:des];
        [taskPhoto addObject: [NSURL URLWithString:photo]];
        
        
    }
    
    NSLog(@"No of Title: %d",[taskTitle count]);
    return self;
    
    
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


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyTaskCell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        
        [[NSBundle mainBundle] loadNibNamed:@"TaskCell" owner:self options:nil];
        
        cell = taskCell;
        
        self.taskCell = nil;
        
    }
    
    UILabel *label;
    
    label = (UILabel *)[cell viewWithTag:2];
    
    label.text = [taskTitle objectAtIndex:indexPath.row];
    
    NSData *imgData = [NSData dataWithContentsOfURL:[taskPhoto objectAtIndex:indexPath.row]];
    
    UIImage *image;
    
    image = (UIImage *)[cell viewWithTag:1];
    
    image = [UIImage imageWithData:imgData];
    
    
    
    return cell;
    
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


@end
