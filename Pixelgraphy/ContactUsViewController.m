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
    
}


- (IBAction)submit:(UIButton *)sender
{
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
    else if ([self verifyPurchaseEmail:[_EmailBox text]])
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
        
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Success"
                                message:@"Your feedback has been recieved"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
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
