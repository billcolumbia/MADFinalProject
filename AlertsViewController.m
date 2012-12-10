//
//  AlertsViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/10/12.
//
//

#import "AlertsViewController.h"

@interface AlertsViewController ()

@end

@implementation AlertsViewController

@synthesize alertsTableView, redLineIncidentsDictionary, appDel, backButton;


-(void)viewWillAppear:(BOOL)animated
{
    // set back button to custom added back button
    [self.navigationItem setBackBarButtonItem:backButton];
    
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    redLineIncidentsDictionary = appDel.redLineIncidentsDictionary;
    NSLog(@"Incidents: %@",redLineIncidentsDictionary);
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([redLineIncidentsDictionary count] == nil)
    {
        return 0;
    }
    else
        return [redLineIncidentsDictionary count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [[[redLineIncidentsDictionary objectForKey:@"Incidents"] objectAtIndex:0] objectForKey:@"Description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// open a alert with an OK and cancel button
    //	NSString *alertString = [NSString stringWithFormat:@"Clicked on row #%d", [indexPath row]];
    //	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    //	[alert show];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void)
     {
         NSLog(@"Dismissed view");
     }];
    
}

@end
