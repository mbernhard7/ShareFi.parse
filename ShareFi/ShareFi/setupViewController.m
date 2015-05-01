//
//  setupViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/29/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "setupViewController.h"
#import <Parse/Parse.h>

@interface setupViewController ()

@end

@implementation setupViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated{
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"setuptomain" sender:self];
    }
    else
    {
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void) presentlogin{
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
