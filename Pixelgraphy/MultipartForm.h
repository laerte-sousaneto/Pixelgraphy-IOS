//
//  MultipartForm.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultipartForm : NSObject

@property NSMutableData* responseData;
@property NSString* boundary;
@property NSMutableData* body;
@property NSMutableURLRequest *request;
@property NSString* contentType;
@property NSData* returnData;

+(MultipartForm*)initWithURL:(NSURL*)url formMethod:(NSString*)method;
-(void)addHeaderFile:(NSData*)file header:(NSString*)headerType;
-(void)addHeaderValue:(NSString*)value withKey:(NSString*)key;
-(void)closeForm;
-(NSString*)sendForm;
-(void)openForm;

@end
