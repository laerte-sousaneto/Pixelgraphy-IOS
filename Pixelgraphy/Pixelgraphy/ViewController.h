//
//  ViewController.h
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 2/24/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingScreenViewController.h"


@interface ViewController : UIViewController

- (IBAction)LoginTouchUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *UsernameRO;
@property (weak, nonatomic) IBOutlet UITextField *PasswordRO;

@property bool failedLoginCallback;

@end
