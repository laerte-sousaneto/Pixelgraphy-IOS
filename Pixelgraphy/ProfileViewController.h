//
//  ProfileViewController.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollViewRO;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *Username;
@property (weak, nonatomic) IBOutlet UILabel *Majors;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *Hometown;
@property (weak, nonatomic) IBOutlet UITextView *HobbiesTextView;
@property (weak, nonatomic) IBOutlet UITextView *BioTextView;
@property (weak, nonatomic) IBOutlet UIView *LoadRO;

@end
