//
//  LogInViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/29/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
NSString *username = _usernameText.text;
NSString *password = _passText.text;
[PFUser logInWithUsernameInBackground:username password:password
                                block:^(PFUser *user, NSError *error) {
                                    if (user) {
                                        
                                        [self performSegueWithIdentifier:@"logtomain" sender:self];
                                    } else {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Credentials provided were incorrect. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                        [alert show];
                                        
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
