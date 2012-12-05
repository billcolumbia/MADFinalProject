//
//  FindStationTableViewController.h
//  DCEZ
//
//  Created by Juan Valera on 12/5/12.
//
//

#import <UIKit/UIKit.h>

@interface FindStationTableViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UITableView *stationsTableView;
@property (nonatomic, strong) NSDictionary *redLineStationsJSON;

@end
