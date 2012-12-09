//
//  ChooseDepartureStationViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import "ChooseDepartureStationViewController.h"
#import "AppDelegate.h"
#import "StandardCustomCell.h"

@interface ChooseDepartureStationViewController ()

@end

@implementation ChooseDepartureStationViewController

@synthesize redLineStationsDictionary, appDel;

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

    // get local copy of redLineStationsDictionary from appDelegate.
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    redLineStationsDictionary = appDel.redLineStationsDictionary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *standardCellNib = [UINib nibWithNibName:@"StandardCustomCell" bundle:nil];
    [[self tableView] registerNib:standardCellNib forCellReuseIdentifier:@"standardCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

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
    return [redLineStationsDictionary[@"Stations"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeOfStation = redLineStationsDictionary[@"Stations"][indexPath.row][@"StationTogether1"];
    NSString *stationName = redLineStationsDictionary[@"Stations"][indexPath.row][@"Name"];

    StandardCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"standardCell"];
    cell.mainTextLabel.text = redLineStationsDictionary[@"Stations"][indexPath.row][@"Name"];
    if ([stationName isEqualToString:@"Fort Totten"] || [stationName isEqualToString:@"Gallery Place"]){ //F01 E06 Green/Yellow/Red
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RedYellowGreenStationBackground.png"]];
    }
    else if ([stationName isEqualToString:@"Metro Center"]){ //This the only red/oragne/blue
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BlueOrangeRedStationBackground.png"]];
    }
    else {
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RedLineStationBackground.png"]];
    }
    //cell.contentView.backgroundColor = [UIColor colorWithRed:.3 green:.2 blue:.2 alpha:1];
    NSLog(@"The station name is %@", stationName);
    NSLog(@"Station Together is %@", typeOfStation);

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // add selected station's code to delegate variable
    appDel.departureStationCode = redLineStationsDictionary[@"Stations"][indexPath.row][@"Code"];
    NSLog(@"departure station code: %@",appDel.departureStationCode);
    
    // push view to next vc
    [self performSegueWithIdentifier:@"ToChooseDestinationStation" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end