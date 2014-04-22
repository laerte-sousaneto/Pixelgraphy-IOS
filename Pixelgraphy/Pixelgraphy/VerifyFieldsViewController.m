//
//  VerifyFieldsViewController.m
//  Pixelgraphy
//
//  Created by ODESSA on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "VerifyFieldsViewController.h"
#import "AccountManager.h"

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
    AccountManager* accountManager = [[AccountManager alloc]init];
    [accountManager setDelegate:self];
    //[accountManager registerUsername:@"doido" Passowrd1:@"1234" Password2:@"1234" Email:@"sousa.lae@gmail.com"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RegisterTouchUp:(UIButton *)sender
{
    if([[_UsernameTextField text] isEqualToString:@""])
    {
        //Tiggered if username field is empty
        NSLog(@"Please specify a username");
    }
    else if(![self checkPassReqs:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        //This is triggered if the entered password does not have at least 8 characters, at least 1 capital letter and at least 1 number
        NSLog(@"Password does not meet requirements");
    }
    else if(![self checkPassMatch:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        //This is triggered if the two passwords do not match
        NSLog(@"Passwords do not match");
    }
    else if(![self verifyPurchaseEmail:[_EmailTextField text]])
    {
        //This is triggered if the email is not an @purchase.edu email
        NSLog(@"Email must be an @purchase.edu email");
    }
    else
    {
        //AT THIS POINT WE CAN SUBMIT THE DATA TO THE PHP FILES TO BEGIN REGISTERING
        NSLog(@"DATA CHECKS OUT, SENDING TO SERVER");
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
    if([email rangeOfString:@"@purchase.edu"].location == NSNotFound)
    {
        return false;
    }
    else
    {
        return true;
    }
}

//HttpRequest protocol callback functions
-(void)beforeSend
{
    //Implement what should happend before request is made.
}
-(void)onSuccess:(NSData*)data;
{
     NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",result);
}
-(void)onError:(NSError*)connectionError
{
    //some code
    NSLog(@"There was an error");
}
@end
