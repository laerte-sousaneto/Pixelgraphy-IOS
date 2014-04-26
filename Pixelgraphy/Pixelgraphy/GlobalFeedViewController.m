//
//  GlobalFeedViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/26/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "GlobalFeedViewController.h"
#import "PhotoInfo.h"
#import "DataRequest.h"
#import "MyPhotoCell.h"
#import "MyTableViewDataSource.h"

@interface GlobalFeedViewController () <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet MyTableViewDataSource *dataSource;


@end

@implementation GlobalFeedViewController

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
    
    //DataRequest* data = [DataRequest initWithUserID:@"52a89642c025c"];
    DataRequest* dataRequest = [DataRequest initWithUserID:userID];
    
    [dataRequest setDelegate:self];
    [dataRequest getGlobalPhotos];
    // Do any additional setup after loading the view.
}

-(void)onSuccess:(NSData*)data
{
    NSMutableArray* tableData = [[NSMutableArray alloc] init];

    NSError* jsonError;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    NSLog(@"%@",[json description]);
    
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
