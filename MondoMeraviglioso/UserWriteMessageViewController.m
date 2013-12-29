//
//  UserWriteMessageViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 27/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserWriteMessageViewController.h"
#import "SendMessageCommand.h"
#import "MessageService.h"
#import "UserService.h"
#import "User.h"
#import "MessageRecipient.h"
#import "GuiHelper.h"

@interface UserWriteMessageViewController ()
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popOver;
@property (strong, nonatomic) IBOutlet UILabel *writeToLabel;
- (IBAction)sendMessage:(id)sender;
- (IBAction)chooseImage:(id)sender;

@end

@implementation UserWriteMessageViewController

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
    self.writeToLabel.text = [NSString stringWithFormat:@"Write a message to %@", self.messageRecipient.screenName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender
{
    UserService *userService = [UserService sharedUserService];
    MessageService *messageService = [MessageService shared];
    
    SendMessageCommand *cmd =
        [[SendMessageCommand alloc] initWithSenderKey:userService.currentUser.key
                                RecipientKey:self.messageRecipient.userKey
                                Title:self.titleTextField.text
                                Body:self.messageTextView.text];
    if(self.thumbnail != Nil)
    {
        cmd.thumbnail = self.thumbnail;
    }
    
    [messageService send:cmd
    success:^
    {
        self.titleTextField.text = @"";
        self.messageTextView.text = @"";
        self.imageView.image = Nil;
        self.thumbnail = Nil;
        
        NSString *sentMsg = [NSString stringWithFormat:
                             @"Message to %@ has been successfully sent",
                             self.messageRecipient.screenName];
        [GuiHelper showMessage:sentMsg withTitle:NSLocalizedString(@"MessageSent", @"")];
    }
    ko:^(NSError *error)
    {
        [GuiHelper showError:error withTitle:NSLocalizedString(@"MessageFailed", @"")];
    }];
    
}

- (IBAction)chooseImage:(id)sender
{
    [self presentImagePicker];
}



@end
