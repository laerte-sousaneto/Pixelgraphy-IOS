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

@interface GlobalFeedViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray* data;

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
    
    self.data = [[NSMutableArray alloc] init];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    
    //DataRequest* data = [DataRequest initWithUserID:@"52a89642c025c"];
    DataRequest* data = [DataRequest initWithUserID:userID];
    
    [data setDelegate:self];
    [data getGlobalPhotos];
    // Do any additional setup after loading the view.
}

-(void)onSuccess:(NSData*)data
{
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
        
        [self.data addObject:photoInfo];
        
        //return to the main thread and update table view
        dispatch_async(dispatch_get_main_queue(),^
        {
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    NSInteger row = indexPath.row;
    PhotoInfo* photoInfo = self.data[row];
    
    MyPhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[MyPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.imageView.image = photoInfo.image;
    cell.title.text = photoInfo.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor =[UIColor darkGrayColor];
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
