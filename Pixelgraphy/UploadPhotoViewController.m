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
#import "MultipartForm.h"

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
    [_ImageViewRO.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [_ImageViewRO.layer setBorderWidth: 1.0];
  
    
}

- (void)didShow
{ 
    _ScrollViewRO.scrollEnabled = true;
}

- (void)didHide
{
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
    [_viewRO setHidden:NO];
    if([_ImageViewRO image] == nil)
    {
        [self showMessage:@"Error" body:@"Please choose an image to upload."];
    }
    else if ([[_ImageNameRO text] isEqualToString:@""])
    {
        [self showMessage:@"Error" body:@"Please specify a name."];
    }
    else if([[_DescriptionRO text] isEqualToString:@""])
    {
        [self showMessage:@"Error" body:@"Please specify a description."];
    }
    else
    {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString* username = [userInfo stringForKey:@"username"];
        NSData *imageData = UIImageJPEGRepresentation([_ImageViewRO image], 1.0f); //serialize image
        
        MultipartForm* sendImage = [MultipartForm initWithURL:[NSURL URLWithString:@"http://pixelgraphy.net/PHP/ImageServerUploaderiOS.php"] formMethod:@"POST"];
        
        [sendImage openForm];
        
        [sendImage addHeaderFile:imageData header:@"image/jpeg"];
        
        [sendImage addHeaderValue:username withKey:@"usr"];
        
        [sendImage addHeaderValue:@"0" withKey:@"isProfile"]; //Not for profile
        
        [sendImage addHeaderValue:[_ImageNameRO text] withKey:@"nameInput"];
        
        [sendImage addHeaderValue:[_DescriptionRO text] withKey:@"descriptionInput"];
        
        [sendImage closeForm];
        
        NSString* returnMessage = [sendImage sendForm];

        NSLog(@"%@", returnMessage);
        
        [self clearUploader];
        
        [self showMessage:@"Done!" body:@"Image has been uploaded"];
    }
    [_viewRO setHidden:YES];
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
-(void)clearUploader
{
    [_ImageNameRO setText:@""];
    [_DescriptionRO setText:@""];
    _ImageViewRO.image = nil;
}

@end
