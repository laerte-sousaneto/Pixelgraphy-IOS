//
//  ContactUsViewController.h
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/7/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *CommentBox;
@property (weak, nonatomic) IBOutlet UITextField *EmailBox;
- (IBAction)submit:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *LoadingRO;

@property (strong, nonatomic) IBOutlet UITextView *ContactUsText;
@property (strong, nonatomic) IBOutlet UITextField *PersonalEmail;
@property (strong, nonatomic) IBOutlet UIButton *Submit;
@end
