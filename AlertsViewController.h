//
//  AlertsViewController.h
//  DCEZ
//
//  Created by Juan Valera on 12/10/12.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AlertsViewController : UIViewController
{
    IBOutlet UITableView *alertsTableView;
}

@property (nonatomic, strong) NSDictionary *redLineIncidentsDictionary;
@property (nonatomic, strong) AppDelegate *appDel;
@property (nonatomic, strong) UITableView *alertsTableView;
@property (nonatomic, strong) UIBarButtonItem *backButton;

-(IBAction) cancelButtonPressed:(id)sender;

@end