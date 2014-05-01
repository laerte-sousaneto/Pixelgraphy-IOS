//
//  CommentsDataSource.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray* data;

@end
