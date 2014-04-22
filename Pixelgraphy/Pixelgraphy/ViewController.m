//
//  ViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 2/24/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequest.h"

@interface ViewController ()
    @property HttpRequest* httpRequest;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSURL* url = [NSURL URLWithString:@"http://pixelgraphy.net/PHP/login_check.php"];
    
    _httpRequest = [HttpRequest initWithURL:url];
    [_httpRequest setDelegate:self];
    [_httpRequest sendHttpRequest:@"&username=laerte&password=1234"];
    
    
}
-(void)onSuccess:(NSData*)data;
{
     NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",result);
}
-(void)onError:(NSError*)connectionError
{
    //some code
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
