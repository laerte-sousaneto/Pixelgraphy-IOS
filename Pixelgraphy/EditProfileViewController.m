//
//  EditProfileViewController.m
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "EditProfileViewController.h"
#import "DataRequest.h"
#import "MultipartForm.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

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
    //Get current profile data
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    DataRequest* dataRequest = [DataRequest initWithUserID:userID];
    [dataRequest setDelegate:self];
    
    [dataRequest getProfileData];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard
{
    [_FullName resignFirstResponder];
    [_Nickname resignFirstResponder];
    [_Hometown resignFirstResponder];
    [_Major resignFirstResponder];
    [_PersonalEmail resignFirstResponder];
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
                       //Load data heir
                       [_FullName setText:jsonProfile[@"fullname"]];
                       //[_Nickname setText:jsonProfile[@"fullname"]];
                       [_Hometown setText:jsonProfile[@"hometown"]];
                       [_PersonalEmail setText:jsonProfile[@"personal_email"]];
                       [_Major setText:jsonProfile[@"major"]];
                       [_Hobbies setText:[NSString stringWithFormat:@"%@", jsonProfile[@"hobbies"]]];
                       [_Biography setText:[NSString stringWithFormat:@"%@", jsonProfile[@"biography"]]];
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


@end
