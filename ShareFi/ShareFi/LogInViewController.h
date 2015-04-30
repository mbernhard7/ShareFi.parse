//
//  LogInViewController.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/29/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LogInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passText;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
