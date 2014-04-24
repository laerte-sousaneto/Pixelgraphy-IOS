//
//  PhotoInfo.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoInfo : NSObject

@property (nonatomic,strong) NSString* ID;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* description;
@property (nonatomic,strong) NSURL* URL;
@property (nonatomic,strong) NSString* date;

+(PhotoInfo*)initWithID:(NSString*)ID Name:(NSString*)name Description:(NSString*)description URL:(NSURL*)URL Date:(NSString*)date;
@end
