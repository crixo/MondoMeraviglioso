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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nearestUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearestUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    User *user = [self.nearestUsers objectAtIndex:indexPath.row];
    
    cell.usernameLabel.text = user.screenName;
    
    return cell;
}

@end
