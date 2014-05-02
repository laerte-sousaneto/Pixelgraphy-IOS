//
//  PhotoDetailsViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/26/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "CommentsViewController.h"

@interface PhotoDetailsViewController ()

@end

@implementation PhotoDetailsViewController

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
    
    [self displayData];
    
    // Do any additional setup after loading the view.
    
    
    [self addStyle];
    [self addTapGesture];
    [self addSwipeGesture];

}
- (void) displayData
{
    _imageView.image = [ [_photos objectAtIndex:_currentIndex] image ];
    _titleLabel.text = [ [_photos objectAtIndex:_currentIndex] name ];
    _descriptionArea.text = [ [_photos objectAtIndex:_currentIndex] description ];
}
-(void) addStyle
{
    //UIImageView Border
    [_imageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [_imageView.layer setBorderWidth: 2.0];
}
-(void) addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
- (void) addSwipeGesture
{
    UISwipeGestureRecognizer* swipeLeftRecognizer = [ [UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft) ];

    [ swipeLeftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];

    [ [self view] addGestureRecognizer:swipeLeftRecognizer];
    
    UISwipeGestureRecognizer* swipeRightRecognizer = [ [UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight) ];

    [ swipeRightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight) ];

    [[self view] addGestureRecognizer:swipeRightRecognizer ];

}
- (void) swipeLeft
{
    if ( _currentIndex > 0 )
        {
            _currentIndex--;
        }
    else
        {
            _currentIndex = [_photos count]-1;
        }
    
    [self displayData];
}
- (void) swipeRight
{

    if( _currentIndex < [_photos count]-1 )
        {
            _currentIndex++;
        }
    else
        {
            _currentIndex = 0;
        }
    
    [self displayData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewComments"])
    {
        CommentsViewController* controller = (CommentsViewController*)segue.destinationViewController;
        
        controller.photos = _photos;
        controller.photoIndex = _currentIndex;
    }
}

-(void)dismissKeyboard
{
    [_descriptionArea resignFirstResponder];
}

@end
