//
//  AppDelegate.m
//  ShareFi
//
//  Created by Miles Bernhard on 4/28/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Reachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"Xw731Ft6PTBw357LUQQFDqn3pwrNwVLl75zssVao"
                  clientKey:@"AwrOoQ3u09InYZKaYGudzJPrHwCoabR7ECnmFed7"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setPublicWriteAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshaccess)
                                                 name:@"refreshaccess" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshaccess" object:nil];
    return YES;
}

-(void)refreshaccess{
    if ([PFUser currentUser]) {
        PFQuery *Query = [PFQuery queryWithClassName:@"networks"];
        [Query whereKey:@"user" equalTo:[[PFUser currentUser]objectForKey:@"username"]];
        [Query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(object){
                    PFUser *log = [PFUser currentUser];
                    log[@"access"] = @YES;
                    [log saveInBackground];
                    
                }
            else if(!(object)){
                PFUser *log = [PFUser currentUser];
                log[@"access"] = @NO;
                [log saveInBackground];
            }
        }];
             }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
