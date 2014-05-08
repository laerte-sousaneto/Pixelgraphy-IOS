//
//  ContactUsViewController.m
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/7/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "ContactUsViewController.h"
#import "MultipartForm.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didShow
{
    _ScrollViewRO.scrollEnabled = true;
    CGPoint point = CGPointMake(0, _CommentBox.frame.size.height * 1.3); //2.5
    [_ScrollViewRO setContentOffset:point animated:YES];
}

- (void)didHide
{
    [_ScrollViewRO setContentOffset:CGPointZero animated:YES];
    _ScrollViewRO.scrollEnabled = false;
}

-(void)dismissKeyboard
{
    [_CommentBox resignFirstResponder];
    [_EmailBox resignFirstResponder];
}


- (IBAction)submit:(UIButton *)sender
{
    [_LoadingRO setHidden:NO];
    if ([[_CommentBox text] isEqualToString:@""])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please write a message to send us!"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else if ([[_EmailBox text]isEqualToString:@""])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please write your e-mail!"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else if (![self verifyPurchaseEmail:[_EmailBox text]])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Email must be an @purchase.edu email!"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else
    {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString* loginName = [userInfo stringForKey:@"username"];
        MultipartForm* newForm = [MultipartForm initWithURL:[NSURL URLWithString:@"http://pixelgraphy.net/PHP/contactUsProcess.php"] formMethod:@"POST"];
        [newForm openForm];
        [newForm addHeaderValue:[_CommentBox text] withKey:@"message"];
        [newForm addHeaderValue:[_EmailBox text] withKey:@"email"];
        [newForm addHeaderValue:loginName withKey:@"name"];
        [newForm closeForm];
        [newForm sendForm];
        
    }
    [_LoadingRO setHidden:YES];
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
@end
