//
//  OverviewTableViewController.h
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface OverviewTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *overviewStationsDictionary;
@property (nonatomic, strong) NSString *departureStationCodeForRequest;
@property (nonatomic, strong) NSString *destinationStationCodeForRequest;
@property (nonatomic, strong) AppDelegate *appDel;

-(IBAction) addToFavorites:(id)sender;

@end
