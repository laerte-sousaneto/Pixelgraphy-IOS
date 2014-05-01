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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib
    
    
    //keyboard tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
- (void)didShow
{
    NSLog(@"keyboard shown");
    _ScrollViewRO.scrollEnabled = true;
    
    CGPoint point = CGPointMake(0, _UsernameRO.frame.size.height * 3.5); //2.5
    [_ScrollViewRO setContentOffset:point animated:YES];
}

- (void)didHide
{
    NSLog(@"Keyboard hidden");
    [_ScrollViewRO setContentOffset:CGPointZero animated:YES];
    _ScrollViewRO.scrollEnabled = false;
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
    
    _UsernameRO.delegate = self;
    _PasswordRO.delegate = self;
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
    [self performLogin];
}

-(void)performLogin
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    /*
    if (textField == _UsernameRO)
    {
        [textField resignFirstResponder];
        [_PasswordRO becomeFirstResponder];
    }
     */
    if (textField == _PasswordRO)
    {
        [textField resignFirstResponder];
        [self performLogin];
    }
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_ViewRO endEditing:YES];
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


-(void)dismissKeyboard
{
    [_UsernameRO resignFirstResponder];
    [_PasswordRO resignFirstResponder];
}
@end
