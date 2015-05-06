//
//  tableViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "tableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomTableViewCell.h"

@interface tableViewController ()

@end

@implementation tableViewController
- (void)viewDidLoad {
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButton:)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = back;
    back.enabled=TRUE;
    back.style=UIBarButtonItemStyleDone;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)backButton:(id)sender{
    [self performSegueWithIdentifier:@"tableback" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"networks";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"ssid";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"location" nearGeoPoint:userGeoPoint withinMiles:10.0];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    CustomTableViewCell *cell = (CustomTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    cell.networkid = [object objectId];
    double distance =[[object objectForKey:@"location"] distanceInMilesTo:userGeoPoint];
    cell.ssidLabel.text = [object objectForKey:@"ssid"];
    cell.passLabel.text =[object objectForKey:@"pass"];
    if (distance<1) {
        distance=(distance*5280);
    
    cell.distLabel.text =[NSString stringWithFormat:@"%d feet",(int)distance];
    }
    else{
        cell.distLabel.text =[NSString stringWithFormat:@"%.2f miles",distance];
    }
    int success=[[object objectForKey:@"sumsuccess"]intValue];
    int entries=[[object objectForKey:@"entries"]intValue];
    int rate=success/entries;
    cell.successLabel.text=[NSString stringWithFormat:@"%d%%",rate];
    if ((success==0)&&(entries==0)) {
    cell.successLabel.text=@"0%";
    }
    return cell;
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
