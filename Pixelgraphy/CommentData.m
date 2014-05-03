//
//  CommentData.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "CommentData.h"

@implementation CommentData

+(CommentData*)initWithID:(NSString *)ID PosterID:(NSString*)posterID PosterName:(NSString *)posterName Comment:(NSString *)comment Date:(NSString *)date
{
    CommentData* newCommentData =[[CommentData alloc]init];
    
    [newCommentData setID:ID];
    [newCommentData setPosterID:posterID];
    [newCommentData setPosterName:posterName];
    [newCommentData setComment:comment];
    [newCommentData setDate:date];
    
    
    return newCommentData;
}

@end
