//
//  LoadingScreenViewController.h
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LoadingScreenViewController : UIViewController
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *password;

@property bool userValidated;
@property bool userFalsified;

@end
