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

//Check if username passed to this class matches any entry on the database.
-(void)checkUsername
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/login_check.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&username=%@&password=%@",_username,_password];
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

//check if username and password passed matches any entry on the database
-(void)checkUsername:(NSString *)username andPassword:(NSString *)password
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/login_check.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&username=%@&password=%@",username,password];
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

//registers a user with respective username, password, and email into the database.
-(void)registerUsername:(NSString *)username Passowrd1:(NSString *)password1 Password2:(NSString *)password2 Email:(NSString *)email
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/register_check.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&username=%@&password1=%@&password2=%@&email=%@"
                            ,username,password1,password2,email];
    
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

@end
