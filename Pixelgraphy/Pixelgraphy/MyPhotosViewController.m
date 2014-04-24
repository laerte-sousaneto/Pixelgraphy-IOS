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

@interface MyPhotosViewController () <UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray* data;

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
    
    self.data = [[NSMutableArray alloc] init];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString* userID = [userInfo stringForKey:@"uuid"];
    
    //DataRequest* data = [DataRequest initWithUserID:@"52a89642c025c"];
    DataRequest* data = [DataRequest initWithUserID:userID];
    
    [data setDelegate:self];
    [data getUserPhotos];
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
    }
    
    [self.tableView reloadData];
    
}
-(void)onError:(NSError*)connectionError
{
    NSLog(@"error");
}
-(void)beforeSend
{

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    PhotoInfo* photoInfo = self.data[row];
    
    MyPhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSData* urlData = [NSData dataWithContentsOfURL:photoInfo.URL];
    UIImage* img = [[UIImage alloc] initWithData:urlData];
    
    cell.imageView.image = img;
    cell.title.text = photoInfo.name;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
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
