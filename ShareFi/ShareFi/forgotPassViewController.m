//
//  forgotPassViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/30/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "forgotPassViewController.h"
#import <Parse/Parse.h>

@interface forgotPassViewController ()

@end

@implementation forgotPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)forgotpassButton:(id)sender {
    PFQuery *query = [PFUser query];
    [query whereKey:@"email" equalTo:_emailText.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(object){
    [PFUser requestPasswordResetForEmailInBackground:_emailText.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Password reset requested. Please check your email to reset your password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No account associated with that email. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

        }
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
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
