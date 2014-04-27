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
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    
    DataRequest* dataRequest = [DataRequest initWithUserID:userID];
    
    [dataRequest setDelegate:self];
    [dataRequest getCommentsWithID:_info.ID];
    
    // Do any additional setup after loading the view.
}

-(void)onSuccess:(NSData*)data
{
    NSMutableArray* tableData = [[NSMutableArray alloc] init];
    NSError* jsonError;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    int jsonLength = [json count];
    
    
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
        controller.info = _info;
    }
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

- (IBAction)BackTouchUp:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
