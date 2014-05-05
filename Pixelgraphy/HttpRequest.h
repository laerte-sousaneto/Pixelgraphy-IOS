//
//  HttpRequest.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

@property NSURL* pageURL;
@property NSMutableData* responseData;
@property id delegate;

+(HttpRequest*)initWithURL:(NSURL*)url;
-(void)sendHttpRequest;
-(void)sendHttpRequest:(NSString*)postString;
-(void)sendHttpRequestImage:(NSData*)imageData;

@end

@interface NSObject(HttpDelegate)
    -(void)onSuccess:(NSData*)data;
    -(void)onError:(NSError*)connectionError;
    -(void)beforeSend;
@end
