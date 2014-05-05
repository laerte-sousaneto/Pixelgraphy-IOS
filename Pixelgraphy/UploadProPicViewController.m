//
//  UploadProPicViewController.m
//  Pixelgraphy
//
//  Created by Skylar Gifford on 5/4/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "UploadProPicViewController.h"

@interface UploadProPicViewController ()

@end

@implementation UploadProPicViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //UIImageView Border
    [_ProfImage.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [_ProfImage.layer setBorderWidth: 1.0];
    
    
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

- (IBAction)AddPhoto:(UIButton *)sender {
}

- (IBAction)UploadPhoto:(UIButton *)sender {
}

-(void)dismissKeyboard
{
    [_PicName resignFirstResponder];
    [_ImageDescript resignFirstResponder];
}
@end
