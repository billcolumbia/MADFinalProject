//
//  ChooseDepartureStationViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import "ChooseDepartureStationViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

@interface ChooseDepartureStationViewController ()

@end

@implementation ChooseDepartureStationViewController

@synthesize redLineStationsDictionary;

NSString *urlString = @"http://api.wmata.com/Rail.svc/json/JStations?LineCode=RD&api_key=";
NSString *keyString = @"bezj8khcsbj4jmsy6km4tjrm";

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     // show spinning indicator on status bar to demonstrate downloading is happening.
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    // here pull API info for the station selected    
    urlString =[urlString stringByAppendingString:keyString];    
    NSURL *apiURL = [NSURL URLWithString:urlString];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:apiURL];
    
    AFJSONRequestOperation *apiOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request %@ success!",request);
        
        // first, capture JSON
                
        redLineStationsDictionary = JSON;
                              
        NSString *testString = redLineStationsDictionary[@"Stations"];
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
    return [redLineStationsDictionary[@"Stations"] count];
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
    cell.textLabel.text= redLineStationsDictionary[@"Stations"][indexPath.row][@"Name"];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // add selected station's code to delegate variable
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDel.departureStationCode = redLineStationsDictionary[@"Stations"][indexPath.row][@"Code"];
    NSLog(@"departure station code: %@",appDel.departureStationCode);
    
    // push view to next vc
    [self performSegueWithIdentifier:@"ToChooseDestinationStation" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end