//
//  MyTableViewDataSource.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/26/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "MyTableViewDataSource.h"
#import "PhotoInfo.h"
#import "MyPhotoCell.h"
#import "PhotoDetailsViewController.h"

@implementation MyTableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    NSInteger row = indexPath.row;
    PhotoInfo* photoInfo = self.data[row];
    
    MyPhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[MyPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.imageView.image = photoInfo.image;
    cell.title.text = photoInfo.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

@end
