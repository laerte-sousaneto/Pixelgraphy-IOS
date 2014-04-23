//
//  ProfileViewController.m
//  Pixelgraphy
//
//  Created by ODESSA on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "ProfileViewController.h"
#import "AccountManager.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    _ScrollViewRO.contentSize =CGSizeMake(320, 1000);
    //The below two lines are how to access the UUID after it is saved after a successful login
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [data stringForKey:@"uuid"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
