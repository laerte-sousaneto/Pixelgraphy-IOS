//
//  UploadProPicViewController.m
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/4/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "UploadProPicViewController.h"
#import "MultipartForm.h"

@interface UploadProPicViewController ()

@end

@implementation UploadProPicViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AddPhoto:(UIButton *)sender
{
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
    [_ProfImage setImage:image];
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)UploadPhoto:(UIButton *)sender
{
    if([_ProfImage image] == nil)
    {
        [self showMessage:@"Error" body:@"Please choose an image to upload."];
    }
    else if ([[_PicName text] isEqualToString:@""])
    {
        [self showMessage:@"Error" body:@"Please specify a name."];
    }
    else if([[_ImageDescript text] isEqualToString:@""])
    {
        [self showMessage:@"Error" body:@"Please specify a description."];
    }
    else
    {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString* username = [userInfo stringForKey:@"username"];
        NSData *imageData = UIImageJPEGRepresentation([_ProfImage image], 1.0f); //serialize image
        
        MultipartForm* sendImage = [MultipartForm initWithURL:[NSURL URLWithString:@"http://pixelgraphy.net/PHP/ImageServerUploaderiOS.php"] formMethod:@"POST"];
        
        [sendImage openForm];
        
        [sendImage addHeaderFile:imageData header:@"image/jpeg"];
        
        [sendImage addHeaderValue:username withKey:@"usr"];
        
        [sendImage addHeaderValue:@"true" withKey:@"isProfile"]; //Not for profile
        
        [sendImage addHeaderValue:[_PicName text] withKey:@"nameInput"];
        
        [sendImage addHeaderValue:[_ImageDescript text] withKey:@"descriptionInput"];
        
        [sendImage closeForm];
        
        NSString* returnMessage = [sendImage sendForm];
        
        NSLog(@"%@", returnMessage);
        
        [self clearUploader];
        
        [self showMessage:@"Done!" body:@"Profile image changed."];
    }

}

-(void)dismissKeyboard
{
    [_PicName resignFirstResponder];
    [_ImageDescript resignFirstResponder];
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
    [_ImageDescript setText:@""];
    [_PicName setText:@""];
    _ProfImage.image = nil;
}
@end
