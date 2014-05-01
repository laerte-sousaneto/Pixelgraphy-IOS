//
//  VerifyFieldsViewController.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyFieldsViewController : UIViewController
- (IBAction)RegisterTouchUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollViewRO;

- (bool)checkPassReqs:(NSString*) pass1 secondPassword:(NSString*) pass2;
- (bool)checkPassMatch:(NSString*) pass1 secondPassword:(NSString*) pass2;;
- (bool)verifyPurchaseEmail:(NSString*)email;
-(void)userResponseMessage:(NSString*)message andTitle: (NSString*)title;

@end
