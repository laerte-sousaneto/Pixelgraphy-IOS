//
//  PhotoInfo.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "PhotoInfo.h"

@implementation PhotoInfo

+(PhotoInfo*)initWithID:(NSString *)ID Name:(NSString *)name Description:(NSString *)description URL:(NSURL *)URL Date:(NSString *)date
{
    PhotoInfo* newPhotoInfo =[[PhotoInfo alloc]init];
    
    [newPhotoInfo setID:ID];
    [newPhotoInfo setName:name];
    [newPhotoInfo setDescription:description];
    [newPhotoInfo setURL:URL];
    [newPhotoInfo setDate:date];
    
    NSData* urlData = [NSData dataWithContentsOfURL:URL];
    [newPhotoInfo setImage:[[UIImage alloc] initWithData:urlData]];
    
    return newPhotoInfo;
}

@end
