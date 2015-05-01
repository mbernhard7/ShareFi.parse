//
//  addwifiViewController.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface addwifiViewController : UIViewController
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITextField *ssidInput;
@property (strong, nonatomic) IBOutlet UITextField *passInput;

@end
