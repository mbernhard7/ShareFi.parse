//
//  CustomTableViewCell.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "tableViewController.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation CustomTableViewCell
@synthesize ssidLabel = _ssidLabel;
@synthesize passLabel = _passLabel;
@synthesize distLabel = _distLabel;
@synthesize successLabel = _successLabel;
@synthesize networkid = _networkid;
@synthesize notworking = _notworking;
@synthesize working = _working;

- (IBAction)settingsButton:(id)sender {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)notworking:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"objectId" equalTo:_networkid];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(object){
            int number=[[object objectForKey:@"entries"]intValue]+1;
            NSNumber *num = [NSNumber numberWithInteger:number];
            [object setObject:num forKey:@"entries"];
            [object saveInBackground];
            _working.hidden=NO;
            _notworking.hidden=YES;
            ;
        }
    }];
}
- (IBAction)working:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"objectId" equalTo:_networkid];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(object){
            int number=[[object objectForKey:@"entries"]intValue]+1;
            NSNumber *num = [NSNumber numberWithInteger:number];
            [object setObject:num forKey:@"entries"];
            int number2=[[object objectForKey:@"sumsuccess"]intValue]+100;
            NSNumber *num2 = [NSNumber numberWithInteger:number2];
            [object setObject:num2 forKey:@"sumsuccess"];
            [object saveInBackground];
            _working.hidden=YES;
            _notworking.hidden=NO;
        }
    }];

}
- (IBAction)mapsButton:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"objectId" equalTo:_networkid];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(object){
            PFGeoPoint *geo=[object objectForKey:@"location"];
            CLLocationCoordinate2D wifilocal = CLLocationCoordinate2DMake(geo.latitude, geo.longitude);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:wifilocal addressDictionary:nil];
            MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
            item.name = _ssidLabel.text;
            [item openInMapsWithLaunchOptions:nil];
        }
    }];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
