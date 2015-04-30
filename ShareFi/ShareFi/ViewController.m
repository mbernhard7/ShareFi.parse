//
//  ViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/28/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated {
    [self presentlogin];
}
- (void) presentlogin{
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"maintosetup" sender:self];
    }
    else
    {
    }
}
- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    [self presentlogin];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
