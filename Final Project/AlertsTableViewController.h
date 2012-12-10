//
//  AlertsTableViewController.h
//  DCEZ
//
//  Created by Juan Valera on 12/10/12.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AlertsTableViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *redLineIncidentsDictionary;
@property (strong, nonatomic) AppDelegate *appDel;

@end
