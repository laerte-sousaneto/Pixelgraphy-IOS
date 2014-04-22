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
	// Do any additional setup after loading the view, typically from a nib.
    
    AccountManager* accountManager = [AccountManager initWithUsername:@"laerte" andPassowrd:@"1234"];
    [accountManager setDelegate:self];
    [accountManager checkUsername];
    
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
        //Send the username and password to php files
        if (true) //This should not always be treue, this should check and see if the login was successful
        {
            //Login successful
            [self performSegueWithIdentifier:@"TabbedVC" sender:self];
        }
        else
        {
            //Login failed
        }
    }
}
@end
