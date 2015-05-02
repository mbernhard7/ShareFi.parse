//
//  custom2TableViewCell.m
//  ShareFi
//
//  Created by Miles Bernhard on 5/1/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "custom2TableViewCell.h"
#import <Parse/Parse.h>
#import "mynetworksViewController.h"

@implementation custom2TableViewCell
@synthesize ssid = _ssid;
@synthesize password = _password;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)edit:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Password" message:@"Please enter new password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    [alertTextField setTextAlignment:NSTextAlignmentCenter];
    [alert show];
}

@end
