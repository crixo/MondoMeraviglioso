//
//  NearestUsersViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 25/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "NearestUsersViewController.h"
#import "NearestUserCell.h"
#import "User.h"
#import "UserService.h"
#import "UserDetailViewController.h"

@interface NearestUsersViewController ()
@property (strong, nonatomic) IBOutlet UITableView *nearestUsersTableView;

@end

@implementation NearestUsersViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Nearest users";
    [self.navigationController setNavigationBarHidden:NO];
    self.nearestUsersTableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearestUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearestUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    User *user = [self.nearestUsers objectAtIndex:indexPath.row];
    
    UserService *userService = [UserService sharedUserService];
    CLLocationDistance distance = [userService.currentUser getDistanceFrom:user];
    
    cell.usernameLabel.text = user.screenName;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%f", distance];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UserDetailViewController *userDetailViewController = segue.destinationViewController;
    
    NSIndexPath *selectedIndex = [self.nearestUsersTableView indexPathForSelectedRow];
    
    userDetailViewController.user = [self.nearestUsers objectAtIndex:selectedIndex.row];
    
    [self.nearestUsersTableView deselectRowAtIndexPath:selectedIndex animated:YES];
}

@end
