//
//  OverviewTableViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import "OverviewTableViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "OverviewCustomCell.h"

@interface OverviewTableViewController ()

@end

@implementation OverviewTableViewController


@synthesize overviewStationsDictionary, departureStationCodeForRequest, destinationStationCodeForRequest, appDel;

NSString *pathUrlString = @"http://api.wmata.com/Rail.svc/json/JPath?FromStationCode=";
NSString *pathKeyString = @"bezj8khcsbj4jmsy6km4tjrm";

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self)
//    {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        self.view.backgroundColor = [UIColor colorWithRed:34 green:37 blue:37 alpha:1];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    pathUrlString = @"http://api.wmata.com/Rail.svc/json/JPath?FromStationCode=";
    
    // test delegate vars     
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    NSLog(@"departure code in overview : %@",appDel.departureStationCode);
    NSLog(@"destination code in overview : %@",appDel.destinationStationCode);
    
    // construct api url with them    
    pathUrlString = [pathUrlString stringByAppendingString:appDel.departureStationCode];
    pathUrlString = [pathUrlString stringByAppendingString:@"&ToStationCode="];
    pathUrlString = [pathUrlString stringByAppendingString:appDel.destinationStationCode];
    pathUrlString = [pathUrlString stringByAppendingString:@"&api_key="];
    pathUrlString =[pathUrlString stringByAppendingString:pathKeyString];
    
    NSLog(@"Final URL: %@", pathUrlString);
    
    // show spinning indicator on status bar to demonstrate downloading is happening.
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    // here make API request for the path between the two stations
    NSURL *apiURL = [NSURL URLWithString:pathUrlString];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:apiURL];
    
    AFJSONRequestOperation *apiOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // Downloading done. Don't show spinning indicator.
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request success!");
        
        // capture JSON
        overviewStationsDictionary = JSON;
        
        [self.tableView reloadData];
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // Downloading done. Don't show spinning indicator.        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request fail :( ");
        NSLog(@"Error: %@", error);
    }];
    
    [apiOperation start];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *myCustomNib = [UINib nibWithNibName:@"StartStation" bundle:nil];
    [[self tableView] registerNib:myCustomNib forCellReuseIdentifier:@"startCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;}
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [overviewStationsDictionary[@"Path"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OverviewCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"startCell"];
    cell.stationName.text = overviewStationsDictionary[@"Path"][indexPath.row][@"StationName"];
        
    NSInteger *countToManipulate = [overviewStationsDictionary[@"Path"] count] - 1;

    if (indexPath.row == 0){
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"StartCellBackground.png"]];
        NSLog(@"This should be start %d", indexPath.row);
    }
    else if (indexPath.row == countToManipulate){
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"EndCellBackground.png"]];
        NSLog(@"This should be end %d", indexPath.row);
        NSLog(@"The count is %d", [overviewStationsDictionary[@"Path"] count]);
    }
    else if (indexPath.row < [overviewStationsDictionary[@"Path"] count] && indexPath.row > 0) {
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MidCellBackground.png"]];
        NSLog(@"This should be mid %d", indexPath.row);
    }
    else{
        NSLog(@"You really messed this up duder!");
    }
    
//    NSLog(@"This IS row %d", indexPath.row);
//    NSLog(@"The total count is %d", [overviewStationsDictionary[@"Path"] count]);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end