//
//  SignUpViewController.h
//  ShareFi
//
//  Created by Miles Bernhard on 4/29/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailText;
@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;

@end
