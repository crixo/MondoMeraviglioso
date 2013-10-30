//
//  ViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "LoginViewController.h"
#import "UserService.h"
#import "LoginCommand.h"
#import "User.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)performLogin:(id)sender;

@end

@implementation LoginViewController

@synthesize txtEmail;
@synthesize txtPassword;
@synthesize spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    txtEmail.delegate = self;
    txtPassword.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    LoginCommand *loginCommand = [[LoginCommand alloc]init];
    loginCommand.email = txtEmail.text;
    loginCommand.password = txtPassword.text;
    
    UserService *sharedUserService = [UserService sharedUserService];
    sharedUserService.loginDelegate = self;
    [sharedUserService login:loginCommand];
}

- (void) loginFailed:(NSError *)error
{
    [self.spinner stopAnimating];
    NSLog(@"%@",[error localizedDescription]);
}

- (void) loginSucceded:(User *)user
{
    [self.spinner stopAnimating];
    NSLog(@"user %@ logged in", user.key);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//keyboard disappears
    return YES;
}
@end
