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
#import "Base64.h"

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
    //[self.navigationController setNavigationBarHidden:NO];
    self.nearestUsersTableView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self.nearestUsersTableView setNeedsDisplay];
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
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0f %@",
                               distance>1000? distance/1000 : distance,
                               distance>1000? @"km":@"mt"];
    CGSize size=CGSizeMake(80, 80);
    cell.imageView.image = [self resizeImage:user.thumbnail imageSize:size];

    //cell.imageView.image = user.thumbnail;
    
//    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cell.imageView.layer.borderWidth = 1.0;
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UserDetailViewController *userDetailViewController = segue.destinationViewController;
    
    NSIndexPath *selectedIndex = [self.nearestUsersTableView indexPathForSelectedRow];
    
    userDetailViewController.user = [self.nearestUsers objectAtIndex:selectedIndex.row];
    
    [self.nearestUsersTableView deselectRowAtIndexPath:selectedIndex animated:YES];
}

@end
