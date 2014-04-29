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
    
}
- (void)viewDidAppear:(BOOL)animated
{
    if (_failedLoginCallback) {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Whoops"
                                message:@"Incorrect Username/Password Specified"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil
                                ];
        [anAlert show];
    }
    _failedLoginCallback = false;
}
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginTouchUp:(UIButton *)sender
{
    if ([[_UsernameRO text] isEqualToString:@""] || [[_PasswordRO text] isEqualToString:@""])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Username and/or password field is blank."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else
    {
        [self performSegueWithIdentifier:@"TabbedVC" sender:self];
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//Sends data to loading screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"TabbedVC"])
    {
        LoadingScreenViewController *controller = (LoadingScreenViewController *)segue.destinationViewController;
        controller.username = [_UsernameRO text];
        controller.password = [_PasswordRO text];
    }
}
@end
