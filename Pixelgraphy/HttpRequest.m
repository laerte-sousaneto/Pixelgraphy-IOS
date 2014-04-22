//
//  HttpRequest.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "HttpRequest.h"

@interface HttpRequest()

    @property NSMutableData* responseData;
    
@end

@implementation HttpRequest

+(HttpRequest*)initWithURL:(NSURL*)url
{
    HttpRequest* newHttpRequest=[[HttpRequest alloc]init];
    [newHttpRequest setPageURL:url];
    
    return newHttpRequest;
}
-(void)sendHttpRequest
{
    NSMutableURLRequest* request = [self setupConnection:_pageURL];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                    queue:[[NSOperationQueue alloc]init]
                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                    {
                        [self completeHandler:data];
            
                    }];
}
-(void)sendHttpRequest:(NSString*)postString
{
    NSMutableURLRequest* request = [self setupConnection:_pageURL withPostString:postString];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                    queue:[[NSOperationQueue alloc]init]
                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                    {
                        [self completeHandler:data];
            
                    }];
}

-(void)completeHandler:(NSData*)data
{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",result);
}
-(NSMutableURLRequest*)setupConnection:(NSURL*)url withPostString:(NSString*)postString
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    
    
    NSData* postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* postLength = [NSString stringWithFormat:@"%ld", [postData length]];
    
    [request setURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    return request;
}

-(NSMutableURLRequest*)setupConnection:(NSURL*)url
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:url];
    
    return request;
}

@end
