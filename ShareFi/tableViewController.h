//
//  tableViewController.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import <Parse/Parse.h>

@interface tableViewController : PFQueryTableViewController
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
