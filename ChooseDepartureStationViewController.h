//
//  ChooseDepartureStationViewController.h
//  DCEZ
//
//  Created by Juan Valera on 12/6/12.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChooseDepartureStationViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *redLineStationsDictionary;
@property (nonatomic, strong) AppDelegate *appDel;

@end
