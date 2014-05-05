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

-(void)sendHttpRequestImage:(NSData*)imageData
{
    NSURL *url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/ImageServerUploaderiOS.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"YOUR_BOUNDARY_STRING";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"%@.jpg\"\r\n", @"Test Jensen"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"message\"\r\n\r\n%@", @"Example Message"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user\"\r\n\r\n%d", 1] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    [_delegate beforeSend];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [_delegate onSuccess:data];
     }];
}
@end
