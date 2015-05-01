//
//  CustomTableViewCell.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ssidLabel;
@property (strong, nonatomic) IBOutlet UILabel *passLabel;
@property (strong, nonatomic) IBOutlet UILabel *distLabel;

@end
