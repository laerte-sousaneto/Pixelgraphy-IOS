//
//  MyPhotosViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "MyPhotosViewController.h"
#import "MyPhotoCell.h"
#import "DataRequest.h"
#import "PhotoInfo.h"
#import "MyTableViewDataSource.h"
#import "PhotoDetailsViewController.h"

@interface MyPhotosViewController () <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet MyTableViewDataSource *dataSource;

@end

@implementation MyPhotosViewController

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
    [dataRequest getUserPhotos];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self becomeFirstResponder];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [_LoadingScreen setHidden:NO];
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString* userID = [userInfo stringForKey:@"uuid"];
        DataRequest* dataRequest = [DataRequest initWithUserID:userID];
        [dataRequest setDelegate:self];
        [dataRequest getUserPhotos];
        NSLog(@"Shake!");
    }
}
-(void)onSuccess:(NSData*)data
{
    NSMutableArray* tableData = [[NSMutableArray alloc] init];
    NSError* jsonError;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    
    for(NSDictionary* entry in json)
    {
        NSString* ID = [entry objectForKey:@"ID"];
        NSString* name = [entry objectForKey:@"name"];
        NSString* description = [entry objectForKey:@"description"];
        NSString* directory = [NSString stringWithFormat:@"http://pixelgraphy.net/%@",[entry objectForKey:@"directory"]];
        NSString* date = [entry objectForKey:@"date"];
        
        NSURL* url = [NSURL URLWithString:directory];
        
        PhotoInfo* photoInfo = [PhotoInfo initWithID:ID Name:name Description:description URL:url Date:date];
        
        [tableData addObject:photoInfo];
        
        //return to the main thread and update table view
        dispatch_async(dispatch_get_main_queue(),^
        {
            self.dataSource.data = tableData;
            [_LoadingScreen setHidden:YES];
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
    [_LoadingScreen setHidden:NO];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"photoDetails"])
    {
        NSIndexPath* indexPath = [_tableView indexPathForSelectedRow];
        PhotoDetailsViewController* controller = (PhotoDetailsViewController*)segue.destinationViewController;
        
        controller.photos = self.dataSource.data;
        controller.currentIndex = (int)indexPath.row;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor =[UIColor darkGrayColor];
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




@end
