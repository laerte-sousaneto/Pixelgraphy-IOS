//
//  LoadingScreenViewController.m
//  Pixelgraphy
//
//  Created by ODESSA on 4/21/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "AccountManager.h"

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController

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
    _userValidated = false;
    _userFalsified = false;
    AccountManager* accountManager = [AccountManager initWithUsername:[self username] andPassowrd:[self password]];
    [accountManager setDelegate:self];
    [accountManager checkUsername];
    /*
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                  target: self
                                                selector:@selector(timeout:)
                                                userInfo: nil repeats:NO];
     */
	// Do any additional setup after loading the view.
}
/*
-(void)timeout:(NSTimer *)timer {
    [self performSegueWithIdentifier:@"BackToLogin" sender:self];
}
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    bool checkConnection = true;
    while (checkConnection)
    {
        if (_userValidated)
        {
            checkConnection = false;
            [self performSegueWithIdentifier:@"TabbedVC2" sender:self];
        }
        else if(_userFalsified)
        {
            checkConnection = false;
            [self performSegueWithIdentifier:@"BackToLogin" sender:self];
        }
    }
}

-(void)beforeSend
{
    //Implement what should happend before request is made.
}
-(void)onSuccess:(NSData*)data;
{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",result);
    if ([result isEqualToString:@"true"]) {
        _userValidated = true;
    }
    else
    {
        _userFalsified = true;
    }
}
-(void)onError:(NSError*)connectionError
{
    //some code
    NSLog(@"There was an error");
}

//If pushed back to login screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BackToLogin"])
    {
        UINavigationController *controller = (UINavigationController *)segue.destinationViewController;
        ViewController *loginvc = (ViewController *)controller.topViewController;
        loginvc.failedLoginCallback = true;
    }
}

@end
