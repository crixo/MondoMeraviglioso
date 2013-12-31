//
//  UIUserMessageListViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserMessageListViewController.h"
#import "Message.h"
#import "MessageUser.h"
#import "MessageCell.h"
#import "User.h"
#import "UserService.h"
#import "MessageService.h"
#import "UserMessageDetailViewController.h"

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
    
    UserService *userService = [UserService sharedUserService];
    MessageService *messageService = [MessageService shared];
    
    [messageService getMessagesFor:userService.currentUser.key success:^(NSArray *messages) {
        self.messages = messages;
        [self.tableView reloadData];
    } ko:^(NSError *error) {
        //
    }];
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
    
    cell.senderScreenNameLabel.text = message.sender.screenName;
    
    cell.titleLabel.text = message.title;
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MessageDetailSegue"])
    {
        UserMessageDetailViewController *vewController =
            segue.destinationViewController;
        
        NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
        
        Message *selectedMessage =[self.messages objectAtIndex:selectedIndex.row];
        
        vewController.messageKey = selectedMessage.key;
        
        [self.tableView deselectRowAtIndexPath:selectedIndex animated:YES];
    }}

@end
