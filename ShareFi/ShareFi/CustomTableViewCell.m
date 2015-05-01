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

@implementation CustomTableViewCell
@synthesize ssidLabel = _ssidLabel;
@synthesize passLabel = _passLabel;
@synthesize distLabel = _distLabel;

- (IBAction)settingsButton:(id)sender {
}
- (IBAction)flagButton:(id)sender {
}
- (IBAction)mapsButton:(id)sender {
  
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
