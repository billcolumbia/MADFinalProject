//
//  FindStationViewController.m
//  Final Project
//
//  Created by Juan Valera on 11/26/12.
//
//

#import "FindStationViewController.h"
#import "AFJSONRequestOperation.h"

@interface FindStationViewController ()

@end

@implementation FindStationViewController

@synthesize allStationsJSON;

NSString *urlString = @"http://api.wmata.com/Rail.svc/json/JStations?LineCode=RD&api_key=";
NSString *keyString = @"bezj8khcsbj4jmsy6km4tjrm";

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // here pull API info for the station selected    
    urlString =[urlString stringByAppendingString:keyString];
    
    NSURL *apiURL = [NSURL URLWithString:urlString];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:apiURL];
    
    AFJSONRequestOperation *apiOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSLog(@"API JSON request %@ success!",request);
        
        // first capture JSON        
        allStationsJSON = JSON;
        
        // call custom callback function that does stuff with JSON and pass in the response JSON.
        [self doStuffWithJSON:allStationsJSON];
        
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"API JSON request fail :( ");
    }];
    
    [apiOperation start];
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


-(void)doStuffWithJSON:(NSDictionary*)JSON
{
    NSLog(@"JSON in doStuffWithJSON is: %@",JSON);
}

@end
