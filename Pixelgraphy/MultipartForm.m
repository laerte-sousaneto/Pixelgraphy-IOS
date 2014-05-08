//
//  MultipartForm.m
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "MultipartForm.h"

@implementation MultipartForm

+(MultipartForm*)initWithURL:(NSURL*)url formMethod:(NSString*)method
{
    MultipartForm* newForm=[[MultipartForm alloc]init];
    
    newForm.request = [[NSMutableURLRequest alloc]init];
    newForm.body = [[NSMutableData alloc]init];
    newForm.boundary = [[NSMutableString alloc]init];
    newForm.returnData = [[NSData alloc]init];
    newForm.contentType = [[NSString alloc]init];
    
    [newForm.request setURL:url];
    [newForm.request setHTTPMethod:method];
    
    return newForm;
}
-(void)addHeaderFile:(NSData*)file header:(NSString*)headerType
{
    [self.body appendData:[[NSString stringWithFormat:@"--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"myFile\"; filename=\"test.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", headerType] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[NSData dataWithData:file]];
    [self.body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}
-(void)addHeaderValue:(NSString*)value withKey:(NSString*)key
{
    NSString *param = value;
    [self.body appendData:[[NSString stringWithFormat:@"--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}
-(void)closeForm
{
            [self.body appendData:[[NSString stringWithFormat:@"--%@--\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
}
-(NSString*)sendForm
{
    [_request setHTTPBody:_body];
    
    //return and test
    self.returnData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:self.returnData encoding:NSUTF8StringEncoding];
    return returnString;
}
-(void)openForm;
{
    self.boundary = @"---------------------------14737809831466499882746641449";
    self.contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", self.boundary];
    [self.request addValue:self.contentType forHTTPHeaderField:@"Content-Type"];
}

@end
