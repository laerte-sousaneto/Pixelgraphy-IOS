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
-(void)getGlobalPhotos
{    
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/globalImagesInJSON.php"];
        
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest];
}
-(void)getCommentsWithID:(NSString*)image_id
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/CommentFeed.getJSON.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&image_id=%@",image_id];
    _identifier = @"getComments";
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}
-(void)postComment:(NSString*)comment userID:(NSString*)userID imageID:(NSString*)imageID
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/CommentFeed.addIPhone.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&comment=%@&userID=%@&imageID=%@",comment,userID,imageID];
    _identifier = @"postComment";
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}
-(void)getProfileData
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/profileReturn.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&userID=%@",_userID];
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}
-(void)uploadImageToServer:(NSString*)username isProfile:(NSString*)isProfile myPicture:(UIImage*)myPicture pictureName:(NSString*)pictureName pictureDescription:(NSString*)pictureDescription
{
    url = [NSURL URLWithString:@"http://test.pixelgraphy.net/PHP/ImageServerUploader.php"];
    
    NSString* postString = [NSString stringWithFormat:@"&usr=%@&isProfile=%@&myFile=%@&nameInput%@&descriptionInput=%@",username, isProfile, myPicture, pictureName, pictureDescription];
    
    http = [HttpRequest initWithURL:url];
    [http setDelegate:_delegate];
    [http setPageURL:url];
    [http sendHttpRequest:postString];
}

@end
