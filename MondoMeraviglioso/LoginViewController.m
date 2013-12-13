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
#import "RegisterViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)performLogin:(id)sender;
- (IBAction)openRegistration:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *loginFailedLabel;

@end

@implementation LoginViewController

@synthesize txtEmail;
@synthesize txtPassword;
@synthesize spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.navigationController setNavigationBarHidden:YES];
    
    txtEmail.delegate = self;
    txtPassword.delegate = self;
    self.loginFailedLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender {
    self.loginFailedLabel.hidden = YES;
    [self.spinner startAnimating];
    
    LoginCommand *loginCommand = [[LoginCommand alloc]init];
    loginCommand.email = txtEmail.text;
    loginCommand.password = txtPassword.text;
    
    UserService *sharedUserService = [UserService sharedUserService];
    sharedUserService.delegate = self;
    [sharedUserService login:loginCommand];
}

- (IBAction)openRegistration:(id)sender {
    RegisterViewController *registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:registerViewController animated:NO completion:nil];
}

- (void) commandFailed:(id)command withError:(NSError *)error
{
    [self.spinner stopAnimating];
    
    self.loginFailedLabel.hidden = NO;
    NSLog(@"%@",[error localizedDescription]);
}

- (void) loginSucceded:(User *)user
{
    [self.spinner stopAnimating];
    NSLog(@"user %@ logged in", user.key);
    //MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    //[self presentViewController:mainViewController animated:NO completion:nil];
    [self performSegueWithIdentifier:@"loginMainSegue" sender:self];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//keyboard disappears
    return YES;
}

//  When we have logged in successfully, we need to pass the managed object context to our table view (via the navigation controller)
//  so we get a reference to the navigation controller first, then get the last controller in the nav stack, and pass the MOC to it
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
//    PictureListMainTable *piclist = (PictureListMainTable *)[[navController viewControllers] lastObject];
//    piclist.managedObjectContext = managedObjectContext;
}
@end
