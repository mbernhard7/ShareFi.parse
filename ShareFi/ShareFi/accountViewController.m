//
//  accountViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 5/1/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "accountViewController.h"
#import <Parse/Parse.h>

@interface accountViewController ()

@end

@implementation accountViewController
-(IBAction)refresh:(id)sender{
    _username.text=[NSString stringWithFormat:@"Username: %@",[[PFUser currentUser] objectForKey:@"username"]];
    _email.text=[NSString stringWithFormat:@"Email: %@",[[PFUser currentUser] objectForKey:@"email"]];
    if ([[[PFUser currentUser] objectForKey: @"access"] isEqual:@NO]) {
        _access.text=@"Access: NO";
    }
    else {
        _access.text=@"Access: YES";
    }
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"user" equalTo:[[PFUser currentUser] objectForKey:@"username"]];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error){
        if (number) {
            _networks.text=[NSString stringWithFormat:@"Networks: %d",number];
        }
        
    }];

}
- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshaccess" object:nil];
    _username.text=[NSString stringWithFormat:@"Username: %@",[[PFUser currentUser] objectForKey:@"username"]];
    _email.text=[NSString stringWithFormat:@"Email: %@",[[PFUser currentUser] objectForKey:@"email"]];
    if ([[[PFUser currentUser] objectForKey: @"access"] isEqual:@NO]) {
        _access.text=@"Access: NO";
    }
    else {
        _access.text=@"Access: YES";
    }
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"user" equalTo:[[PFUser currentUser] objectForKey:@"username"]];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error){
        if (number) {
            _networks.text=[NSString stringWithFormat:@"Networks: %d",number];
        }

    }];
    UIBarButtonItem *logout = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Logout"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(logout:)];
    self.navigationItem.rightBarButtonItem = logout;
    [super viewDidLoad];

}

-(IBAction)logout:(id)sender{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"accountlogout" sender:self];
}
- (IBAction)changepass:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:[[PFUser currentUser] objectForKey:@"email"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Password reset requested. Please check your email to reset your password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [PFUser logOut];
    [self performSegueWithIdentifier:@"accountlogout" sender:self];
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
