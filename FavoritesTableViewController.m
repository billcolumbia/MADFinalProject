//
//  FavoritesTableViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import "FavoritesTableViewController.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController

@synthesize favoritesArray;

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
        // plist does not exist, show blank favorites 
        NSLog(@"Favorites.plist does not exist in favoritesVC.");

    }
    else if(favoritesPlistExists == YES)
    {
        // plist does exist, show in tableview
        NSLog(@"Favorites.plist exists in favoritesVC.");
        favoritesArray = [[NSArray alloc] initWithContentsOfFile:pathToPlist];
        NSLog(@"favoritesArray: %@", favoritesArray);
    }
    else
    {
        NSLog(@"World End. Favrites.plist neither exists nor does not exist.");
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return favoritesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // 0-title, 1-departure station code, 2- destination station code
    cell.textLabel.text = [[favoritesArray objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // click on a fav
    // send it's two codes forward to OverviewTableViewController
    
//    [self performSegueWithIdentifier:@"ToOverview" sender:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
