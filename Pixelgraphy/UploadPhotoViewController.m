//
//  UploadPhotoViewController.m
//  Pixelgraphy
//
//  Created by PAVEGLIO, ANTHONY on 4/24/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "DataRequest.h"
#import "HttpRequest.h"

@interface UploadPhotoViewController ()

@end

@implementation UploadPhotoViewController


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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //UIImageView Border
    [_ImageViewRO.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [_ImageViewRO.layer setBorderWidth: 2.0];
  
    
}

- (void)didShow
{
    NSLog(@"keyboard shown");
    _ScrollViewRO.scrollEnabled = true;
}

- (void)didHide
{
    NSLog(@"Keyboard hidden");
    [_ScrollViewRO setContentOffset:CGPointZero animated:YES];
    _ScrollViewRO.scrollEnabled = false;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddPhotoTouchUp:(UIButton *)sender
{
    //[UploadPhotoViewController resignFirstResponder];
    
    //show the app menu
    [[[UIActionSheet alloc] initWithTitle:nil
                                 delegate:self
                        cancelButtonTitle:@"Close"
                   destructiveButtonTitle:nil
                        otherButtonTitles:@"Take photo", @"Camera Roll", nil]
     showInView:self.view];
   
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if (TARGET_IPHONE_SIMULATOR) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        imagePickerController.editing = YES;
        imagePickerController.delegate = (id)self;
            
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
    else if(buttonIndex == 1)
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.editing = YES;
        imagePickerController.delegate = (id)self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"User Canceled");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_ImageViewRO setImage:image];
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)UploadTO:(UIButton *)sender
{
    if([_ImageViewRO image] == nil)
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please choose an image to upload."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else if ([[_ImageNameRO text] isEqualToString:@""])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please specify a name."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else if([[_DescriptionRO text] isEqualToString:@""])
    {
        UIAlertView* anAlert = [ [UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please specify a description."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil
                                ];
        [anAlert show];
    }
    else
    {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        //NSString* userID = [userInfo stringForKey:@"uuid"];
        NSString* username = [userInfo stringForKey:@"username"];
        
        NSString *urlString = @"http://pixelgraphy.net/PHP/ImageServerUploaderiOS.php";
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        // file
        NSData *imageData = UIImageJPEGRepresentation([_ImageViewRO image], 1.0f);
        
        // file
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"myFile\"; filename=\"test.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // user name here
        NSString *param1 = username;
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"usr\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[param1 dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // is profile
        NSString *param2 = @"0";
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"isProfile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[param2 dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Image name
        NSString *param3 = [_ImageNameRO text];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nameInput\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[param3 dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Image Description
        NSString *param4 = [_DescriptionRO text];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"descriptionInput\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[param4 dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // close form
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // set request body
        [request setHTTPBody:body];
        
        //return and test
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", returnString);
        
        
    }
}

-(void)dismissKeyboard
{
    [_DescriptionRO resignFirstResponder];
    [_ImageNameRO resignFirstResponder];
}
-(void)beforeSend
{
    //Implement what should happend before request is made.
}
-(void)onSuccess:(NSData*)data;
{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@", result);
    //This block of code is changing me and my life -- Anthony
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       //
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

@end
