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

@interface OverviewTableViewController ()

@end

@implementation OverviewTableViewController


@synthesize overviewStationsDictionary, departureStationCodeForRequest, destinationStationCodeForRequest;
                               //api.wmata.com/Rail.svc/json/JPath?FromStationCode=A10&ToStationCode=B05&api_key=

NSString *urlString3 = @"http://api.wmata.com/Rail.svc/json/JPath?FromStationCode=";
NSString *keyString3 = @"bezj8khcsbj4jmsy6km4tjrm";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    // test delegate vars     
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    NSLog(@"departure code in overview : %@",appDel.departureStationCode);
    NSLog(@"destination code in overview : %@",appDel.destinationStationCode);
    
    // construct api url with them    
    urlString3 = [urlString3 stringByAppendingString:appDel.departureStationCode];
    urlString3 = [urlString3 stringByAppendingString:@"&ToStationCode="];
    urlString3 = [urlString3 stringByAppendingString:appDel.destinationStationCode];
    urlString3 = [urlString3 stringByAppendingString:@"&api_key="];
    
    // for some reason, this request already has the key.
//    urlString3 = [urlString3 stringByAppendingString:keyString3];
    
    NSLog(@"key: %@",keyString3);
    NSLog(@"total url: %@", urlString3);
    
    // make request
    
    // show spinning indicator on status bar to demonstrate downloading is happening.
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    // here pull API info for the station selected
    urlString3 =[urlString3 stringByAppendingString:keyString3];
    NSURL *apiURL = [NSURL URLWithString:urlString3];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:apiURL];
    
    AFJSONRequestOperation *apiOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request %@ success!",request);
        
        // first, capture JSON
        
        overviewStationsDictionary = JSON;
        
        NSString *testString = overviewStationsDictionary[@"Stations"];
        // NSLog(@"all red line stations: %@",testString);
        
        // reload tableView
        [self.tableView reloadData];
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request fail :( ");
        NSLog(@"Error: %@", error);
    }];
    
    [apiOperation start];    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
      
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // NSLog(@"TableView Section: %d, Row: %d", indexPath.section, indexPath.row);
    
    // Configure the cell...    
    // cell text label set to station names
    cell.textLabel.text= overviewStationsDictionary[@"Path"][indexPath.row][@"StationName"];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"ToOverview" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end