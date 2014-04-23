//
//  AccountManager.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

@property NSString* username;
@property NSString* password;
@property NSString* uuid;
@property id delegate;

+(AccountManager*) initWithUsername:(NSString *)username andPassowrd:(NSString *)password;

-(void)checkUsername;
-(void)checkUsername:(NSString*)username andPassword:(NSString *)password;
-(void)registerUsername:(NSString*)username Passowrd1:(NSString *)password Password2:(NSString *)password2 Email:(NSString *) email;

@end
