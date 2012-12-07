//
//  AppDelegate.h
//  Final Project
//
//  Created by Juan Valera on 10/23/12.
//
//

#import <UIKit/UIKit.h>
#import "FindStationTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *departureStationCode;
@property (strong, nonatomic) NSString *destinationStationCode;

@end
