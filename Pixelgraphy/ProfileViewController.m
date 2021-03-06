//
//  ProfileViewController.m
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "ProfileViewController.h"
#import "AccountManager.h"
#import "DataRequest.h"
#import "PhotoInfo.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    [_LoadRO setHidden:NO];
    _ScrollViewRO.contentSize =CGSizeMake(320, 1000);
    //The below two lines are how to access the UUID after it is saved after a successful login
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    
    DataRequest* dataRequest = [DataRequest initWithUserID:userID];
    
    [dataRequest setDelegate:self];
    [dataRequest getProfileData];
    
    
    //UIImageView Border
    [_ProfileImage.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [_ProfileImage.layer setBorderWidth: 1.0];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onSuccess:(NSData*)data
{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSDictionary *jsonProfile =
    [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       //Gonna break this up into functions later, just wanted to get it working
                       NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
                       NSString* loginName = [userInfo stringForKey:@"username"];
                       [_fullName setText:jsonProfile[@"fullname"]];
                       [_email setText:jsonProfile[@"personal_email"]];
                       [_Majors setText:jsonProfile[@"major"]];
                       [_Hometown setText:[NSString stringWithFormat:@"%@, %@", jsonProfile[@"hometown"], jsonProfile[@"homestate"]]];
                       [_dob setText:jsonProfile[@"DOB"]];
                       [_HobbiesTextView setText:[NSString stringWithFormat:@"%@", jsonProfile[@"hobbies"]]];
                       [_BioTextView setText:jsonProfile[@"biography"]];
                       [_Loginname setText:loginName];
                       NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://pixelgraphy.net/",jsonProfile[@"profile_picture"]];
                       NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                       NSData* urlData = [NSData dataWithContentsOfURL:url];
                       
                       [_ProfileImage setImage:[[UIImage alloc] initWithData:urlData]];
                       [_LoadRO setHidden:YES];
                       [self.view setNeedsDisplay];
                   });
    
}
-(void)onError:(NSError*)connectionError
{
    NSLog(@"error");
}
-(void)beforeSend
{
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self becomeFirstResponder];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [_LoadRO setHidden:NO];
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString* userID = [userInfo stringForKey:@"uuid"];
        DataRequest* dataRequest = [DataRequest initWithUserID:userID];
        [dataRequest setDelegate:self];
        [dataRequest getProfileData];
        NSLog(@"Shake!");
    }
}

@end
