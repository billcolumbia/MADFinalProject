//
//  ChooseDestinationStationViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import "ChooseDestinationStationViewController.h"
#import "AppDelegate.h"

@interface ChooseDestinationStationViewController ()

@end

@implementation ChooseDestinationStationViewController


@synthesize redLineStationsDictionary, appDel;

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
    
    // get local copy of redLineStationsDictionary from appDelegate.
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    redLineStationsDictionary = appDel.redLineStationsDictionary;
    NSLog(@"redLineStationDictionary in ChooseDestination is: %@",redLineStationsDictionary);
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
    NSLog(@"In choose destination, redlinejson count: %i",[redLineStationsDictionary[@"Stations"] count]);
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
    appDel.destinationStationCode = redLineStationsDictionary[@"Stations"][indexPath.row][@"Code"];
    NSLog(@"destination station code: %@",appDel.destinationStationCode);

    [self performSegueWithIdentifier:@"ToOverview" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end