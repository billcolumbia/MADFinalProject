//
//  AppDelegate.h
//  Final Project
//
//  Created by Juan Valera on 10/23/12.
//
//

#import <UIKit/UIKit.h>
#import "FIndStationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *redLineStationsDictionary;
@property (strong, nonatomic) NSDictionary *redLineStationPredictionsDictionary;
@property (strong, nonatomic) NSDictionary *redLineIncidentsDictionary;
@property (strong, nonatomic) NSString *departureStationCode;
@property (strong, nonatomic) NSString *destinationStationCode;
@property (strong, nonatomic) AppDelegate *appDel;

@end
