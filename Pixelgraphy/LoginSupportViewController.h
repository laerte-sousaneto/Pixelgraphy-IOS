//
//  LoginSupportViewController.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSupportViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *RecoverPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *RecoverUsernameText;
- (IBAction)RecoverPasswordTouchUp:(UIButton *)sender;
-(void)userResponseMessage:(NSString*)message andTitle: (NSString*)title;

@end
