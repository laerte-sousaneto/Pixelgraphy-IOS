//
//  CommentsViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/27/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "CommentsViewController.h"
#import "DataRequest.h"
#import "CommentData.h"
#import "PhotoDetailsViewController.h"

@interface CommentsViewController ()
{
    DataRequest* dataRequest;
    NSString* userID;
    PhotoInfo* photoInfo;
}
@end

@implementation CommentsViewController

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
    self.commentArea.delegate = self;
    
    photoInfo = [_photos objectAtIndex:_photoIndex];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    userID = [userInfo stringForKey:@"uuid"];
    
    dataRequest = [DataRequest initWithUserID:userID];
    [dataRequest setDelegate:self];
    [dataRequest getCommentsWithID:  photoInfo.ID];
    
    _tableView.backgroundColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

-(void)onSuccess:(NSData*)data
{
    NSString* identifier = [dataRequest identifier];
    
    if ([identifier isEqualToString:@"getComments"])
    {
    
        NSMutableArray* tableData = [[NSMutableArray alloc] init];
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];

        NSUInteger jsonLength = [json count];

        [json description];
        if (jsonLength > 0)
        {
            for(NSDictionary* entry in json)
            {
                NSString* ID = [entry objectForKey:@"ID"];
                NSString* posterName = [entry objectForKey:@"poster"];
                NSString* posterID = [entry objectForKey:@"posterID"];
                NSString* comment = [entry objectForKey:@"comment"];
                NSString* date = [entry objectForKey:@"date"];
            
                CommentData* commentData = [CommentData initWithID:ID PosterID:posterID PosterName:posterName Comment:comment Date:date];
            
                [tableData addObject:commentData];
            
                //return to the main thread and update table view
                dispatch_async(dispatch_get_main_queue(),^
                {
                    self.dataSource.data = tableData;
                    [self.tableView reloadData];
                    
                });
                
                
            }
            
        }
        else
        {
                CommentData* commentData = [CommentData initWithID:@"" PosterID:@"" PosterName:@"" Comment:@"There's no comments." Date:@""];
            
                [tableData addObject:commentData];
            
                //return to the main thread and update table view
                dispatch_async(dispatch_get_main_queue(),^
                {
                    self.dataSource.data = tableData;
                   
                    [self.tableView reloadData];
                    
                });
        }
    }
    else if ([identifier isEqualToString:@"postComment"])
    {
        [dataRequest getCommentsWithID: photoInfo.ID];
    }
}
- (void) scrollToBottom
{
    NSArray * tableIndexPath = [self.tableView indexPathsForVisibleRows];
    
    NSIndexPath* lastIndexPath = [tableIndexPath objectAtIndex:[tableIndexPath count]-1];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)onError:(NSError*)connectionError
{
    NSLog(@"error");
}
-(void)beforeSend
{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackPhotoDetails"])
    {
        PhotoDetailsViewController* controller = (PhotoDetailsViewController*)segue.destinationViewController;
        controller.photos = _photos;
        controller.currentIndex = _photoIndex;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addComment:(id)sender
{
    NSString* comment = [_commentArea.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    _commentArea.text = comment;
    
    if ([comment length] > 0)
    {
        NSString* comment = _commentArea.text;
        [dataRequest postComment:comment userID:userID imageID: photoInfo.ID];
        
        _commentArea.text = @"";
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    

}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView endEditing:YES];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
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

- (IBAction)BackTouchUp:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didShow
{
    _ScrollView.scrollEnabled = true;
    CGPoint point = CGPointMake(0, _AddComments.frame.size.height * 6.0); //2.5
    [_ScrollView setContentOffset:point animated:YES];
}

- (void)didHide
{
    [_ScrollView setContentOffset:CGPointZero animated:YES];
    _ScrollView.scrollEnabled = false;
}


-(void)dismissKeyboard
{
    [_commentArea resignFirstResponder];
}
@end
