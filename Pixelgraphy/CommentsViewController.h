//
//  CommentsViewController.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsDataSource.h"
#import "PhotoInfo.h"

@interface CommentsViewController : UIViewController<UITableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet CommentsDataSource *dataSource;

@property (nonatomic) NSMutableArray* photos;
@property (nonatomic) int photoIndex;

@property (nonatomic) IBOutlet UITextView *commentArea;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UIButton *AddComments;

@end
