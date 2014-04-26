//
//  PhotoDetailsViewController.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/26/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoInfo.h"

@interface PhotoDetailsViewController : UIViewController

@property (nonatomic) PhotoInfo* info;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionArea;

@end
