//
//  EditProfileViewController.h
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *FullName;
@property (strong, nonatomic) IBOutlet UITextField *Nickname;
@property (strong, nonatomic) IBOutlet UITextField *Hometown;
@property (strong, nonatomic) IBOutlet UITextField *Major;
@property (strong, nonatomic) IBOutlet UITextField *PersonalEmail;

@end