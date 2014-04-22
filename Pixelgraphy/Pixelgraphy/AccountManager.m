//
//  AccountManager.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "AccountManager.h"
#import "HttpRequest.h"

@interface AccountManager()
{
    HttpRequest* http;
    NSURL* url;
}
@end

@implementation AccountManager

+(AccountManager *) initWithUsername:(NSString *)username andPassowrd:(NSString *)password
{
    AccountManager* newAccountManager = [[AccountManager alloc]init];
    
    [newAccountManager setUsername:username];
    [newAccountManager setPassword:password];
    
    return newAccountManager;
}
-(void)checkUsername
{
    url = [NSURL URLWithString:@"http://pixelgraphy.net/PHP/login_check.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&username=%@&password=%@",_username,_password];
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}
-(void)checkUsername:(NSString *)username andPassword:(NSString *)password
{
    url = [NSURL URLWithString:@"http://pixelgraphy.net/PHP/login_check.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&username=%@&password=%@",username,password];
    
    
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

@end
