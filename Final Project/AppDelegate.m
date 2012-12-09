//
//  AppDelegate.m
//  Final Project
//
//  Created by Juan Valera on 10/23/12.
//
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@implementation AppDelegate

@synthesize redLineStationsDictionary, appDel;

// url strings to request all the red line stations
NSString *urlString = @"http://api.wmata.com/Rail.svc/json/JStations?LineCode=RD&api_key=";
NSString *keyString = @"bezj8khcsbj4jmsy6km4tjrm";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     // show spinning indicator on status bar to demonstrate downloading is happening.
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    // here pull API info for the station selected    
    urlString =[urlString stringByAppendingString:keyString];    
    NSURL *apiURL = [NSURL URLWithString:urlString];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:apiURL];
    
    AFJSONRequestOperation *apiOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
         // Download done, stop spinning indicator.
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSLog(@"API JSON request in AppDelegate success!");
        
        //capture JSON, store here and in appDel var.
        appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDel.redLineStationsDictionary = JSON;
        redLineStationsDictionary = JSON;                              
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // Download stopped/failed, stop spinning indicator.        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
        NSLog(@"API JSON request fail :( ");
        NSLog(@"Error: %@", error);
    }];
    
    [apiOperation start];
    UIView *bgView = [[UIView alloc]initWithFrame:_window.frame];
    
    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MetroBackground.png"]];
    [_window addSubview:bgView];
    bgView.contentMode = UIViewContentModeScaleToFill;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
