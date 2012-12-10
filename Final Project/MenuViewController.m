//
//  MenuViewController.m
//  DCEZ
//
//  Created by Juan Valera on 12/3/12.
//
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize testString;

UIViewController *presentedVC;

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
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

- (IBAction)cancelButtonPressed:(id)sender
{
    NSLog(@"Pressed. presentedVC is %@", presentedVC);
    
    [self dismissViewControllerAnimated:YES completion:^(void)
     {
         NSLog(@"Dismissed view");
     }];
}

@end
