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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *newpass = [alertView textFieldAtIndex:0].text;
        if (newpass.length>=6){
            PFQuery *query = [PFQuery queryWithClassName:@"networks"];
            [query whereKey:@"user" equalTo:[[PFUser currentUser] objectForKey:@"username"]];
            [query whereKey:@"ssid" equalTo:_ssid.text];
            [query whereKey:@"pass" equalTo:_password.text];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                
                object[@"pass"]=newpass;
                
            
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"WiFi password updated." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshtable" object:nil];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to update password. Please check your internet access and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];

                }
            }];
            }];
          


        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

        }
 
    }
}

@end
