//
//  VerifyFieldsViewController.h
//  Pixelgraphy
//
//  Created by ODESSA on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyFieldsViewController : UIViewController
- (IBAction)RegisterTouchUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;

@end
