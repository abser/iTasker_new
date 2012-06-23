//
//  LoginModel.h
//  TabedTemplateApp
//
//  Created by Nurul Abser on 24/5/12.
//  Copyright (c) 2012 abser@zingmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
@interface LoginModel : NSObject <FBSessionDelegate>
{
    Facebook *facebook;
}
@property (nonatomic , retain) Facebook *facebook;
+(id) getLoginData;
+(BOOL) saveLoginData:user pass:(NSString *)pass sessionKey:(NSString *)sessionKey;
+(BOOL) resetLoginData;
+(id) sendLoginToServer:user pass:(NSString *)password;
+(void) logout;
-(void) initializeFB;
@end
