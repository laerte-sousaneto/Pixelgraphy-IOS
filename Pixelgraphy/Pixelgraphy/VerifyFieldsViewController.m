//
//  VerifyFieldsViewController.m
//  Pixelgraphy
//
//  Created by ODESSA on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "VerifyFieldsViewController.h"

@interface VerifyFieldsViewController ()

@end

@implementation VerifyFieldsViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RegisterTouchUp:(UIButton *)sender
{
    if(![self checkPassReqs:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        //This is triggered if the entered password does not have at least 8 characters, at least 1 capital letter and at least 1 number
        NSLog(@"Password does not meet requirements");
    }
    else if(![self checkPassMatch:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        //This is triggered if the two passwords do not match
        NSLog(@"Passwords do not match");
    }
    else if(false)
    {
        
    }
    else
    {
        //AT THIS POINT WE CAN SUBMIT THE DATA TO THE PHP FILES TO BEGIN REGISTERING
    }
}

-(bool)checkPassMatch:(NSString *)pass1 secondPassword:(NSString *)pass2
{
    if ([pass1 isEqualToString:pass2])
    {
        return true;
    }
    else
    {
        return false;
    }
}

- (bool)checkPassReqs:(NSString *)pass1 secondPassword:(NSString *)pass2
{
    bool result = true;
    NSCharacterSet* numbers = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* upperCase = [NSCharacterSet uppercaseLetterCharacterSet];
    if([pass1 length] < 8)
    {
        result = false;
    }
    else if([pass1 rangeOfCharacterFromSet:upperCase].location == NSNotFound)
    {
        result = false;
    }
    else if([pass1 rangeOfCharacterFromSet:numbers].location == NSNotFound)
    {
        result = false;
    }
    return result;
}

- (bool)verifyPurchaseEmail:(NSString *)email
{
    return false;
}
@end
