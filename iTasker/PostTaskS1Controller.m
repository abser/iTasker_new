//
//  PostTaskS1Controller.m
//  iTasker
//
//  Created by Nurul Abser on 27/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "PostTaskS1Controller.h"
#import "PostTaskS2Controller.h"
#import "JSON.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@implementation PostTaskS1Controller
@synthesize taskTitle = _taskTitle;
@synthesize category = _category;
@synthesize description = _description;
@synthesize catList = _catList;
@synthesize catListId = _catListId;
@synthesize picker;
@synthesize keyboardToolbar;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Setting Keyboard Toolbar
    if(keyboardToolbar == nil)
    {
        keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,44)];
        keyboardToolbar.backgroundColor = [UIColor clearColor];
        keyboardToolbar.opaque = NO;
        keyboardToolbar.translucent = YES;
        
         
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyBoard:)];
        
        [keyboardToolbar setItems:[[[NSArray alloc] initWithObjects:doneButton,nil] autorelease]];
    }
    
    self.description.inputAccessoryView = keyboardToolbar;
    
    //[self getAndSetCategoryList];
    
    self.catList = [[NSMutableArray alloc]init];
    self.catListId = [[NSMutableArray alloc]init];
//    
//    NSString *urlstring =  [NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/gettaskcategory/itmoapp"];
//    
//    NSURL *url = [NSURL URLWithString:urlstring];
//    
//    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    //NSLog(@"%@",jsonString);
//    
//    NSDictionary *results = [jsonString JSONValue];
//    NSLog(@"%@",results);
//    
//    
//    for(NSDictionary *result in results)
//    {
//        //NSString *cat_id = [result objectForKey:@"id"];     
//        NSString *cat_name = [result objectForKey:@"category_name"];        
//        NSLog(@"Cat:%@",cat_name);
//        
//        //[self.catList addObject:cat_name];
//        
//    }
    [self.catList addObject:@"House Work" ];
    [self.catList addObject:@"Food Take Away"];
    [self.catList addObject:@"Delivery"];
    [self.catList addObject:@"IKEA Assembly"];
    
    [self.catListId addObject:@"1"];
    [self.catListId addObject:@"2"];
    [self.catListId addObject:@"3"];
    [self.catListId addObject:@"4"];
    
    self.taskTitle.delegate = self;
    self.category.delegate = self;
    self.description.delegate = self;
    

}


-(void)resignKeyBoard:(id)sender
{
    if([self.description isFirstResponder])
    {
        [self.description resignFirstResponder];
    }
}


- (void)viewDidUnload
{
    [self setTaskTitle:nil];
    [self setCategory:nil];
    [self setDescription:nil];
    [super viewDidUnload];
}


/**********************************
 * Manage Keyboard 
 */
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//-(void)textFieldDidBeginEditing:(UITextField *)sender
//{
//    if ([sender isEqual:self.description])
//    {
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
//    }
//}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"Count:%d",[_catList count]);
    return [_catList count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //NSLog(@"Added Cat:%@",[catList objectAtIndex: row]);
    return [_catList objectAtIndex: row];
}

// Picked DidSelect
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSString *selCat = [_catList objectAtIndex:row];
    selCatID = [_catListId objectAtIndex:row];
    
    self.category.text = selCat;
    [picker setHidden:TRUE];
    //[selCat release];
    //[selCatID release];
}

// ...
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// .....
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Category list function -- not using
-(NSArray *)getAndSetCategoryList
{
    NSString *urlstring =  [NSString stringWithFormat:@"http://itasker.infobasehost.com/index.php/jsonapi/gettaskcategory/itmoapp"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",jsonString);
    
    NSDictionary *results = [jsonString JSONValue];
    NSLog(@"%@",results);
    
    
    for(NSDictionary *result in results)
    {
        //NSString *cat_id = [result objectForKey:@"id"];     
        NSString *cat_name = [result objectForKey:@"category_name"];        
        NSLog(@"Cat:%@",cat_name);
        
        [self.catList addObject:cat_name];
        
    }
    return self.catList;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


// Button action to trigger Picker
- (IBAction)showCatPicker:(id)sender {
    picker = [[UIPickerView alloc] init];
    [picker setDataSource: self];
    [picker setDelegate: self];
    [picker setFrame: CGRectMake(0,136, 300, 216.0)];
    
    picker.showsSelectionIndicator = YES;
    // Allow us to pre-select the third option in the pickerView.
    //[picker selectRow:2 inComponent:0 animated:YES];
    // OK, we are ready. Add the picker in our view.
    //self.category.inputView = picker;
    [self.view addSubview: picker];
    
    
}


// Continue button action
- (IBAction)GoS2:(id)sender {
    
    NSUserDefaults *taskData = [NSUserDefaults standardUserDefaults];
    [taskData setObject:self.taskTitle.text forKey:@"taskTitle"]; 
    [taskData setObject:selCatID forKey:@"catId"]; 
    [taskData setObject:self.description.text forKey:@"taskDes"];
    
    //[taskData release];
    //[selCatID release];
    
    
    PostTaskS2Controller *ptS2 = [[PostTaskS2Controller alloc] initWithNibName:@"PostTaskS2View" bundle:nil];
    
    ptS2.title = @"Fee";
    
    self.navigationItem.backBarButtonItem = nil;
    //self.navigationItem.rightBarButtonItem = // Add Cancel button
    
    [self.navigationController pushViewController:ptS2 animated:NO];
}


// Dealloc
- (void)dealloc {
    [picker release];
    [_taskTitle release];
    [_category release];
    [_catList release];
    [_description release];
    [super dealloc];
}
@end
