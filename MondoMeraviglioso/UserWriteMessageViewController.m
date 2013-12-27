//
//  UserWriteMessageViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 27/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserWriteMessageViewController.h"

@interface UserWriteMessageViewController ()
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
- (IBAction)sendMessage:(id)sender;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
}
@end
