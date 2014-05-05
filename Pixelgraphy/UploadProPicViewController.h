//
//  UploadProPicViewController.h
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/4/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadProPicViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *ProfImage;
@property (strong, nonatomic) IBOutlet UITextField *PicName;
@property (strong, nonatomic) IBOutlet UITextView *ImageDescript;


- (IBAction)AddPhoto:(UIButton *)sender;
- (IBAction)UploadPhoto:(UIButton *)sender;


@end



