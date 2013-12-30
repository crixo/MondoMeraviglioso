//
//  UIUserMessageListViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserMessageListViewController.h"
#import "Message.h"
#import "MessageCell.h"
#import "User.h"
#import "UserService.h"

@interface UserMessageListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserMessageListViewController

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
    self.title = @"Message List";
    //[self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Message *message = [self.messages objectAtIndex:indexPath.row];
    
    UserService *userService = [UserService sharedUserService];
    
    return cell;
}

@end
