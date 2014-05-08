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
    [_Biography resignFirstResponder];
    [_Hobbies resignFirstResponder];
    [_StateRO resignFirstResponder];
    [_BirthdayRO resignFirstResponder];
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
                       [_Nickname setText:jsonProfile[@"nickname"]];
                       [_Hometown setText:jsonProfile[@"hometown"]];
                       [_PersonalEmail setText:jsonProfile[@"personal_email"]];
                       [_Major setText:jsonProfile[@"major"]];
                       [_StateRO setText:jsonProfile[@"homestate"]];
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


- (IBAction)submitChangesTouchUp:(UIButton *)sender
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    MultipartForm* data = [MultipartForm initWithURL:[NSURL URLWithString:@"http://pixelgraphy.net/PHP/update_settingsiOS.php"] formMethod:@"POST"];
    
    [data openForm];
    
    //[sendImage addHeaderFile:imageData header:@"image/jpeg"];
    
    [data addHeaderValue:userID withKey:@"uuid"];
    
    [data addHeaderValue:[_FullName text] withKey:@"fullname"];
    
    [data addHeaderValue:[_Hometown text] withKey:@"hometown"];
    
    [data addHeaderValue:[_StateRO text] withKey:@"homestate"];
    
    [data addHeaderValue:[_Nickname text] withKey:@"nickname"];
    
    [data addHeaderValue:[_PersonalEmail text] withKey:@"personal_email"];
    
    [data addHeaderValue:[_Major text] withKey:@"major"];
    
    [data addHeaderValue:[_Hobbies text] withKey:@"hobbies"];
    
    [data addHeaderValue:[_Biography text] withKey:@"biography"];
    
    [data closeForm];
    
    NSString* returnMessage = [data sendForm];
    
    NSLog(@"%@", returnMessage);
    [self showMessage:@"Changes successful!" body:@"Your profile was successfully modified"];

}

-(void)showMessage:(NSString*)title body:(NSString*)body
{
    UIAlertView* anAlert = [ [UIAlertView alloc]
                            initWithTitle:title
                            message:body
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles: nil
                            ];
    [anAlert show];
}
@end
