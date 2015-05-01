//
//  ViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/28/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
       [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated {
    self.locationManager = [[CLLocationManager alloc]init];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

}
- (IBAction)find:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled]&&(status!=kCLAuthorizationStatusNotDetermined)&&(status!=kCLAuthorizationStatusDenied)) {
        [self performSegueWithIdentifier:@"findtotable" sender:self];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot determine location. Make sure location services are enabled. Also, go to Settings>Privacy>Location Services>ShareFi and make sure it's set to always." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
