//
//  FavViewController.m
//  Final Project
//
//  Created by Juan Valera on 11/26/12.
//
//

#import "FavViewController.h"

@interface FavViewController ()

@end

@implementation FavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    // forces VC to show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // check if favs exist in a .plist
    // if yes, import them
    // if not, show blank favs screen
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
