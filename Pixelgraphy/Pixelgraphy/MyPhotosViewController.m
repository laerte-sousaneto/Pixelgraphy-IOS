//
//  MyPhotosViewController.m
//  Pixelgraphy
//
//  Created by Laerte Sousa Neto on 4/23/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "MyPhotosViewController.h"
#import "MyPhotoCell.h"

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
    
     
    static NSInteger count = 1000;
    
    self.data = [[NSMutableArray alloc] initWithCapacity:count];

    NSMutableArray* urls = [[NSMutableArray alloc]init];
    
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    [urls addObject:@"http://pixelgraphy.net/user_home/534effd7b8de7_home/535152125d7a9_homepage.jpg"];
    
    for(NSInteger i = 0; i < [urls count]; i++)
    {
        id path = [urls objectAtIndex:i];
        NSURL* url = [NSURL URLWithString:path];
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* img = [[UIImage alloc] initWithData:data];
        [self.data addObject:img];
    }
    
    // Do any additional setup after loading the view.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UIImage* data = self.data[row];
    
    MyPhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.backgroundColor = [UIColor whiteColor];
    //cell.textLabel.text = data;
    cell.imageView.image = data;
    
    
    
    /*if([data isEqualToString:@"5"])
    {
        cell.backgroundColor = [UIColor orangeColor];
    }*/
    
    return cell;
}
static NSString* CellID = @"Cell";
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
