//
//  SignUpViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/29/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)signup:(id)sender {
    PFUser *user = [PFUser user];
    user.username = _usernameText.text;
    user.password = _passwordText.text;
    user.email = _emailText.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            [self performSegueWithIdentifier:@"signtomain" sender:self];
             }
    }];
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
