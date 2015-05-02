//
//  mynetworksViewController.m
//  ShareFi
//
//  Created by Miles Bernhard on 5/1/15.
//  Copyright (c) 2015 Miles Bernhard. All rights reserved.
//

#import "mynetworksViewController.h"
#import "custom2TableViewCell.h"

@interface mynetworksViewController ()

@end

@implementation mynetworksViewController

- (void)viewDidLoad {
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"networks";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"ssid";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"networks"];
    [query whereKey:@"user" equalTo:[[PFUser currentUser] objectForKey:@"username"]];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"mynetworks";
    
    custom2TableViewCell *cell = (custom2TableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[custom2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.ssid.text = [object objectForKey:@"ssid"];
    cell.password.text =[object objectForKey:@"pass"];
        return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
                           PFObject *object = [self.objects objectAtIndex:indexPath.row];
                    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Network removed. In order to have access to the find network feature, you must have at least one working network." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];

                        }
                        else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:(@"%@",error.localizedDescription)] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];

                        }
                        [self loadObjects];
                    }];
            }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
