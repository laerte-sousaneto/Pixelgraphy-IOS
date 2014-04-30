//
//  LoginSupportViewController.m
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/16/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "LoginSupportViewController.h"
#import "AccountManager.h"
#import "VerifyFieldsViewController.h"

@interface LoginSupportViewController ()

@end

@implementation LoginSupportViewController

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

- (IBAction)RecoverPasswordTouchUp:(UIButton *)sender
{
    AccountManager* accountManager = [[AccountManager alloc]init];
    [accountManager setDelegate:self];
    [accountManager recoverUserPass:[_RecoverPasswordText text]];
}

//Callbacks
-(void)beforeSend
{
    //Implement what should happend before request is made.
}
-(void)onSuccess:(NSData*)data;
{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //This block of code is changing me and my life -- Anthony
    dispatch_async(dispatch_get_main_queue(),^
                   {
                      [self userResponseMessage:result andTitle:@"Recovery Help"];
                   });
    
}
-(void)onError:(NSError*)connectionError
{
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       NSLog(@"ERROR!!!!");
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

@end
