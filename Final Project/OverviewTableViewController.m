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
    // show nav bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // reset url in case this isn't the first time this view is being loaded.
    pathUrlString = @"http://api.wmata.com/Rail.svc/json/JPath?FromStationCode=";
    
    // test delegate vars     
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    departureStationCodeForRequest = appDel.departureStationCode;
    destinationStationCodeForRequest = appDel.destinationStationCode;
//    NSLog(@"departure code in overview : %@",departureStationCodeForRequest);
//    NSLog(@"destination code in overview : %@",destinationStationCodeForRequest);
    
    // construct api url with them    
    pathUrlString = [pathUrlString stringByAppendingString:departureStationCodeForRequest];
    pathUrlString = [pathUrlString stringByAppendingString:@"&ToStationCode="];
    pathUrlString = [pathUrlString stringByAppendingString:destinationStationCodeForRequest];
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
        // if is first station in list...
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"StartCellBackground.png"]];
    }
    else if (indexPath.row == countToManipulate){
        // if is last station in list...        
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"EndCellBackground.png"]];
    }
    else if (indexPath.row < [overviewStationsDictionary[@"Path"] count] && indexPath.row > 0) {
        // if is a station in list not first or last...
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MidCellBackground.png"]];
    }
    else{
        NSLog(@"You really messed this up duder!");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)addToFavorites:(id)sender
{
    NSLog(@"Departure: %@, Destination: %@",departureStationCodeForRequest,destinationStationCodeForRequest);
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Route Name" message:@"What would you like to name this favorite route?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.placeholder = @"School to home";
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // do nothing, they clicked 'cancel.'
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        
        
        // save entered text as title along with two station codes.
        
        // add title and codes into array
        NSString *newFavoriteTitle = [[alertView textFieldAtIndex:0] text];
        NSArray *newFavoriteArray = [[NSArray alloc] initWithObjects:newFavoriteTitle,departureStationCodeForRequest, destinationStationCodeForRequest, nil];
        
        // make path to document directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pathToPlist = [documentsDirectory stringByAppendingString:@"Favorites.plist"];
        
        // check if Favorites.plist exists.
        BOOL favoritesPlistExists = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        favoritesPlistExists = [fileManager fileExistsAtPath:pathToPlist];
        
        if(favoritesPlistExists == NO)
        {
            // plist does not exist, make new.
            NSLog(@"Favorites.plist does not exist.");
        }
        else if(favoritesPlistExists == YES)
        {
            // plist does exist, pull out into nsmutable array
            // write the whole mutable array into the plist
            NSLog(@"Favorites.plist exists.");            
        }
        else
        {
            NSLog(@"World End. Favrites.plist neither exists nor does not exist.");
        }
        
        // if so, pull its contents into an NSMutable Array
            // add the new items to the mutable array
            // write the whole mutable array into the plist
        
        // if not, create it and save the new array into it.
        
       
        // 
    }
}

@end