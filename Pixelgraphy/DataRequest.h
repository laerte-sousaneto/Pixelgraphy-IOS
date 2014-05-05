//
//  DataRequest.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataRequest : NSObject

@property NSString* userID;
@property id delegate;
@property NSString* identifier;

+(DataRequest*)initWithUserID:(NSString*) userID;
-(void)getUserPhotos;
-(void)getGlobalPhotos;
-(void)getProfileData;
-(void)getCommentsWithID:(NSString*)image_id;
-(void)postComment:(NSString*)comment userID:(NSString*)userID imageID:(NSString*)imageID;

@end
