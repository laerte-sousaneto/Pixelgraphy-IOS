//
//  UploadPhotoViewController.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/24/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPhotoViewController : UIViewController<UIActionSheetDelegate>


- (IBAction)AddPhotoTouchUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewRO;
@property (weak, nonatomic) IBOutlet UITextField *ImageNameRO;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionRO;
- (IBAction)UploadTO:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollViewRO;


@end
