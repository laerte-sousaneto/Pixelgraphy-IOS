//
//  DataRequest.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "DataRequest.h"
#import "HttpRequest.h"

@interface DataRequest()
{
    HttpRequest* http;
    NSURL* url;
}
@end

@implementation DataRequest

+(DataRequest*)initWithUserID:(NSString*)userID
{
    DataRequest* newDataRequest = [[DataRequest alloc]init];
    
    [newDataRequest setUserID:userID];
    
    return newDataRequest;
}
-(void)getUserPhotos
{
    //NSMutableArray* data = [[NSMutableArray alloc]init];
    
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/imagesInJSON.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&userID=%@",_userID];
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

@end
