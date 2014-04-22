//
//  ViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 2/24/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "ViewController.h"
#import "AccountManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    _userValidated = false;
    
}
-(void)beforeSend
{
    //Implement what should happend before request is made.
}
-(void)onSuccess:(NSData*)data;
{
     NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",result);
<<<<<<< HEAD
    if ([result isEqualToString:@"true"])
    {
        userValidated = true;
=======
    if ([result isEqualToString:@"true"]) {
        _userValidated = true;
>>>>>>> c3c9a74bef0ecbc9641afd417969abddfe45ef69
    }
    
}
-(void)onError:(NSError*)connectionError
{
    //some code
    NSLog(@"There was an error");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginTouchUp:(UIButton *)sender
{
    if ([[_UsernameRO text] isEqualToString:@""] || [[_PasswordRO text] isEqualToString:@""])
    {
        NSLog(@"Username and/pr password field is blank");
    }
    else
    {
        AccountManager* accountManager = [AccountManager initWithUsername:[_UsernameRO text] andPassowrd:[_PasswordRO text]];
        [accountManager setDelegate:self];
        [accountManager checkUsername];
        [NSThread sleepForTimeInterval:1.0];
<<<<<<< HEAD
        if (userValidated)
=======
        if (_userValidated)
>>>>>>> c3c9a74bef0ecbc9641afd417969abddfe45ef69
        {
            [self performSegueWithIdentifier:@"TabbedVC" sender:self];
        }
        
    }
}
@end
