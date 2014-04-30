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
@property (nonatomic) PhotoInfo* info;
@property (nonatomic) IBOutlet UITextView *commentArea;

@end
