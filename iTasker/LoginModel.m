//
//  LoginModel.m
//  TabedTemplateApp
//
//  Created by Nurul Abser on 24/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import "LoginModel.h"
#import "KeychainItemWrapper.h"

static NSString* APP_ID = @"300862099993835";
@implementation LoginModel

@synthesize facebook;

NSString *_user;
NSString *_pass;
NSString *_session;

-(id)init
{
    self = [super init];
    if(self)
    {
        facebook =  [[Facebook alloc]initWithAppId:APP_ID andDelegate:self];

    }
    return self;
}

+(id) getLoginData
{
    KeychainItemWrapper *keyChain = [[[KeychainItemWrapper alloc] initWithIdentifier:@"iTasker" accessGroup:nil] autorelease];
    //[keyChain setObject:user forKey:kSecAttrAccount];
    //[keyChain setObject:pass forKey:kSecValueData];
    
    _user = [keyChain objectForKey:kSecAttrAccount];
    _pass = [keyChain objectForKey:kSecValueData];    
    _session = [keyChain objectForKey:kSecAttrLabel];
     
    NSLog(@"Retrive User Credential: User: %@ , Pass: %@",_user , _pass);
   
    return [NSArray arrayWithObjects:_user, _pass, _session, nil];
}




+(BOOL) saveLoginData:user pass:(NSString *)pass sessionKey:(NSString *)sessionKey
{
    //[self resetLoginData];
    
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"iTasker" accessGroup:nil];
    [keyChain resetKeychainItem];
    
    NSLog(@"KeyChain Reseted");
    
    NSLog(@"Saving Login data for user: %@",user);
    NSLog(@"Saving use name: %@",user);
    [keyChain setObject:user forKey:kSecAttrAccount];
    NSLog(@"Saving password name: %@",pass);
    [keyChain setObject:pass forKey:kSecValueData]; 
    NSLog(@"Saving sess key : %@",sessionKey);
    [keyChain setObject:sessionKey forKey:kSecAttrLabel];
    [keyChain release];
    return TRUE;
    
}


+(BOOL) resetLoginData
{
KeychainItemWrapper *keyChain = [[[KeychainItemWrapper alloc] initWithIdentifier:@"iTasker" accessGroup:nil] autorelease];
    [keyChain resetKeychainItem];
    return TRUE;
}

+(void) logout
{
    [self resetLoginData];
}


+(id)sendLoginToServer:(id)user pass:(NSString *)password
{
    // POST DATA STRING
    NSString *post = [NSString stringWithFormat:@"&user=%@&pass=%@",user ,password];
    
    // ENCODE THE STRING AS DATA
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    // CALCUATE THE STRIN LENGTH
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    //CREATE URL REQUEST 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //SET URL
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/test/index.php"]]];
    
    // SET POST METHOD
    [request setHTTPMethod:@"POST"];
    
    //HEADER
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    //NOW CONNECT
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]autorelease];
    
    NSLog(@"Response: %@",returnString);
    return returnString;

}



-(void) initializeFB
{
    //facebook = [[Facebook alloc] initWithAppId:@"289622131103120" andDelegate:self];
    facebook = [[Facebook alloc] initWithAppId:@"300862099993835" andDelegate:self]; 
    
}


-(BOOL) checkSessionValidity
{
    if (![facebook isSessionValid]) {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}


/***********************
 *Below Methods are the implementation of protocol methods
 *************************/
// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}



// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"Return Data:res");
    return [facebook handleOpenURL:url]; 
}



- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

- (void)fbDidNotLogin:(BOOL)cancelled
{

}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{

}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
        NSLog(@"FBToken erased!");
        
        
    }
}

- (void)fbSessionInvalidated
{

}



@end
