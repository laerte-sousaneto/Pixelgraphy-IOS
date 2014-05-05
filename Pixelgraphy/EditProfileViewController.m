//
//  EditProfileViewController.m
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard
{
    [_FullName resignFirstResponder];
    [_Nickname resignFirstResponder];
    [_Hometown resignFirstResponder];
    [_Major resignFirstResponder];
    [_PersonalEmail resignFirstResponder];
}

@end
