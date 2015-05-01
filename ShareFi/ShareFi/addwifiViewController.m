//
//  addwifiViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "addwifiViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "Reachability.h"
@interface addwifiViewController ()

@end

@implementation addwifiViewController

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    reachability.reachableOnWWAN = NO;
    if ([reachability isReachable]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        NSString *ssidInput= CFDictionaryGetValue(myDict, kCNNetworkInfoKeySSID);
        _ssidInput.text=ssidInput;
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot detect current WiFi network. Please connect to wifi." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    self.locationManager = [[CLLocationManager alloc]init];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)submitwifiButton:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled]&&(status!=kCLAuthorizationStatusNotDetermined)&&(status!=kCLAuthorizationStatusDenied)) {
    
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    reachability.reachableOnWWAN = NO;
    if ([reachability isReachable]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        NSString *ssidInput= CFDictionaryGetValue(myDict, kCNNetworkInfoKeySSID);
        if ([_ssidInput.text isEqualToString:ssidInput]) {
            if (_passInput.text.length>=6) {
                PFObject *network = [PFObject objectWithClassName:@"networks"];
                PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
                network[@"user"] = [[PFUser currentUser] objectForKey:@"username"];
                network[@"ssid"] = _ssidInput.text;
                network[@"pass"] = _passInput.text;
                network[@"flagged"]= @NO;
                network[@"location"]=point;
                [network saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [self.view endEditing:YES];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The network has been added. You can delete this network from the 'Account' tab. If this network is flagged as not working, your access will be revoked until you adjust it." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [[PFUser currentUser] setObject:@NO forKey:@"accessrevoked"];
                        
                    }
                    else {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                    }
                }];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your SSID does not match your current network. Please connect to the WiFi network you're trying to add and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot detect current WiFi network. Please connect to wifi." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot determine location. Make sure location services are enabled. Also, go to Settings>Privacy>Location Services>ShareFi and make sure it's set to always." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }

 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
