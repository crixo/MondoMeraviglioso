//
//  UserDetailViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserDetailViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
}
@end
