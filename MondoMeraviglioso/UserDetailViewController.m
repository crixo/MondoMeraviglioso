//
//  UserDetailViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserWriteMessageViewController.h"
#import "MessageUser.h"
#import "User.h"
#import "Base64.h"

@interface UserDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userTypeLabel;
@property (strong, nonatomic) IBOutlet UITextView *userDescriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userThumbnailImageView;
@property (strong, nonatomic) IBOutlet UITextView *messageToSendTextView;
- (IBAction)sendMessage:(id)sender;

@end

@implementation UserDetailViewController

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
    
    self.title = self.user.screenName;
    self.userEmailLabel.text = self.user.email;
    self.userTypeLabel.text = [User getTypeAsString:(int)self.user.type];
    self.userThumbnailImageView.image = self.user.thumbnail;
    
    //self.userDescriptionTextView.hidden = (self.user.description.length == 0);
    self.userDescriptionTextView.text = (self.user.description.length == 0)
        ? NSLocalizedString(@"NoDescription", @"No description available")
        : self.user.description;
    
    //To make the border look very close to a UITextField
    [self.messageToSendTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.messageToSendTextView.layer setBorderWidth:2.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UserWriteMessageViewController *viewController = segue.destinationViewController;
    
    viewController.messageRecipient = [[MessageUser alloc]initWithUserKey:self.user.key AndScreenName:self.user.screenName];
}
@end
