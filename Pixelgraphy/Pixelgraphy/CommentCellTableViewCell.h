//
//  CommentCellTableViewCell.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *posterName;
@property (weak, nonatomic) IBOutlet UITextView *comment;

@end
