//
//  HttpRequest.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "HttpRequest.h"

@interface HttpRequest()

@end

@implementation HttpRequest

+(HttpRequest*)initWithURL:(NSURL*)url
{
    HttpRequest* newHttpRequest=[[HttpRequest alloc]init];
    [newHttpRequest setPageURL:url];
    
    return newHttpRequest;
}

//Retrieves a page from the connection url.
-(void)sendHttpRequest
{
    NSMutableURLRequest* request = [self setupConnection:_pageURL];
    
    [_delegate beforeSend];
    
    [NSURLConnection sendAsynchronousRequest:request
                    queue:[[NSOperationQueue alloc]init]
                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                    {
                        [_delegate onSuccess:data];
                    }];
}

//Passes a post request to the url page
-(void)sendHttpRequest:(NSString*)postString
{
    NSMutableURLRequest* request = [self setupConnection:_pageURL withPostString:postString];
    
    [_delegate beforeSend];
    
    [NSURLConnection sendAsynchronousRequest:request
                    queue:[[NSOperationQueue alloc]init]
                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                    {
                        [_delegate onSuccess:data];
                    }];
}

//Setup connection with url and post data in string format
-(NSMutableURLRequest*)setupConnection:(NSURL*)url withPostString:(NSString*)postString
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    
    
    NSData* postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
    
    [request setURL: url];
    [request setHTTPBody: postData];
    [request setHTTPMethod: @"POST"];
    [request setValue: postLength forHTTPHeaderField: @"Content-Length"];
    
    return request;
}

//setup connection with url. (will only retrieve its html content)
-(NSMutableURLRequest*)setupConnection:(NSURL*)url
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:url];
    
    return request;
}
@end
