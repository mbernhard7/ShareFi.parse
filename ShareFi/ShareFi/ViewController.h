//
//  ViewController.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/28/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *logOut;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

