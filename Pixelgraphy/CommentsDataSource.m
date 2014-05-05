//
//  CommentsDataSource.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "CommentsDataSource.h"
#import "CommentCellTableViewCell.h"
#import "CommentData.h"

@implementation CommentsDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"CommentCell";
    NSInteger row = indexPath.row;
    
    CommentData* commentData = self.data[row];
    
    CommentCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        {
            cell = [[CommentCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

    cell.posterName.text = commentData.posterName;
    cell.comment.text = commentData.comment;
    
    
    UITextView* cellTextView = cell.comment;
    
    [cellTextView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [cellTextView.layer setBorderWidth: 0.3];
    
    /*if([self.data count]> 0)
    {
        
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([self.data count] - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }*/
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

@end
