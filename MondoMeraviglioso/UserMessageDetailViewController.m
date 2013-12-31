//
//  UserMessageDetailViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserMessageDetailViewController.h"
#import "Message.h"
#import "MessageUser.h"
#import "MessageService.h"
#import "NSDate+Formatting.h"

@interface UserMessageDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;
@property (strong, nonatomic) IBOutlet UILabel *sentAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation UserMessageDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MessageService *messageService = [MessageService shared];
    [messageService getMessageByKey:self.messageKey success:^(Message *message) {
        self.title = message.title;
        self.bodyTextView.text = message.body;
        self.senderLabel.text = message.sender.screenName;
        self.sentAtLabel.text = [message.sentAt toLocal];
    } ko:^(NSError *error) {
        //
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
