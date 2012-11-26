//
//  SettingsModalViewController.m
//  Final Project
//
//  Created by Juan Valera on 11/19/12.
//
//

#import "SettingsModalViewController.h"

@interface SettingsModalViewController ()

@end

@implementation SettingsModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationController.navigationBarHidden = NO;
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"%@",self.navigationController);
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


- (void)add:(id)sender
{
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    
    SettingsModalViewController *addController= [[SettingsModalViewController alloc] init];
    
    // Configure the SettingModalViewController. In this case, it reports any changes to a custom delegate object.
    //    addController.delegate = self;
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    
    [self presentViewController:navigationController animated:YES completion: nil];
    
}


@end
