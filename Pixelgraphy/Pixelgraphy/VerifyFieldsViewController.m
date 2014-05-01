//
//  VerifyFieldsViewController.m
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/16/14.
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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}

- (void)didShow
{
    NSLog(@"keyboard shown");
    _ScrollViewRO.scrollEnabled = true;
}

- (void)didHide
{
    NSLog(@"Keyboard hidden");
    [_ScrollViewRO setContentOffset:CGPointZero animated:YES];
    _ScrollViewRO.scrollEnabled = false;
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
        [self userResponseMessage:@"Please specify a username." andTitle:@"Error!"];
        NSLog(@"Please specify a username");
    }
    else if(![self checkPassReqs:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        [self userResponseMessage:@"Password does not meet requirements." andTitle:@"Error!"];
        NSLog(@"Password does not meet requirements");
    }
    else if(![self checkPassMatch:[_PassOneTextField text] secondPassword:[_PassTwoTextField text]])
    {
        [self userResponseMessage:@"Passwords do not match" andTitle:@"Error!"];
        NSLog(@"Passwords do not match");
    }
    else if(![self verifyPurchaseEmail:[_EmailTextField text]])
    {
        [self userResponseMessage:@"Email must be an @purchase.edu email" andTitle:@"Error!"];
        NSLog(@"Email must be an @purchase.edu email");
    }
    else
    {
        //AT THIS POINT WE CAN SUBMIT THE DATA TO THE PHP FILES TO BEGIN REGISTERING
        AccountManager* accountManager = [[AccountManager alloc]init];
        [accountManager setDelegate:self];
        [accountManager registerUsername:[_UsernameTextField text] Passowrd1:[_PassOneTextField text] Password2:[_PassTwoTextField text] Email:[_EmailTextField text]];
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
    //This block of code is changing me and my life -- Anthony
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [_PassOneTextField setText:@""];
                       [_PassTwoTextField setText:@""];
                       [_UsernameTextField setText:@""];
                       [_EmailTextField setText:@""];
                           [self userResponseMessage:@"Successfully registered! Check your email for further instructions." andTitle:@"Success!"];
                   });
    
}
-(void)onError:(NSError*)connectionError
{
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [self userResponseMessage:@"Contact application adminstrator, there was an unusual error." andTitle:@"Error!"];
                   });
    NSLog(@"There was an error");
}
-(void)userResponseMessage:(NSString*)message andTitle: (NSString*)title
{
    UIAlertView* anAlert = [ [UIAlertView alloc]
                            initWithTitle:title
                            message:message
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles: nil
                            ];
    [anAlert show];
}

-(void)dismissKeyboard
{
    [_EmailTextField resignFirstResponder];
    [_PassTwoTextField resignFirstResponder];
    [_PassOneTextField resignFirstResponder];
    [_UsernameTextField resignFirstResponder];
}

@end
