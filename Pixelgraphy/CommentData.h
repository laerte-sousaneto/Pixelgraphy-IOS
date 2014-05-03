//
//  CommentData.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentData : NSObject

@property (nonatomic,strong) NSString* ID;
@property (nonatomic,strong) NSString* posterID;
@property (nonatomic,strong) NSString* posterName;
@property (nonatomic,strong) NSString* comment;
@property (nonatomic,strong) NSString* date;

+(CommentData*)initWithID:(NSString *)ID PosterID:(NSString*)posterID PosterName:(NSString *)posterName Comment:(NSString *)comment Date:(NSString *)date;
@end
