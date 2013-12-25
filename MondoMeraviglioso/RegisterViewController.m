//
//  RegisterViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "LoginViewController.h"
#import "Base64.h"
#import "ImageHelper.h"
#import "RegisterCommand.h"
#import "GuiHelper.h"

@interface RegisterViewController ()

@property (strong, nonatomic) IBOutlet GSRadioButtonSetController *userTypeRadioButtonSet;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UITextField *screenNameTextField;

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)chooseThumbnail:(id)sender;

- (IBAction)register:(id)sender;
- (IBAction)goBackToLogin:(id)sender;

@end

@implementation RegisterViewController
{
    NSNumber *selectedUserTypeIndex;
    NSString *thumbnail;
}

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
    
    
    thumbnail = @"";
	// Do any additional setup after loading the view.
    /*
    NSArray *options =[[NSArray alloc]
                       initWithObjects: @"Couple", nil];//[NSNumber numberWithInt:Couple]
    MIRadioButtonGroup *group =[[MIRadioButtonGroup alloc]
                                initWithFrame:CGRectMake(0, 20, 320, 75)
                                andOptions:options andColumns:1];
    
    [self.userTypesRadioButtonGroup addSubview:group];    
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GSRadioButtonSetController delegate methods
- (void)radioButtonSetController:(GSRadioButtonSetController *)controller didSelectButtonAtIndex:(NSUInteger)selectedIndex
{
    //self.selectedIndexLabel.text = [NSString stringWithFormat:@"%d", selectedIndex];
    selectedUserTypeIndex = [[NSNumber alloc]initWithInteger: selectedIndex];
    NSLog(@"selected user type: %lu", (unsigned long)selectedIndex);
}

- (IBAction)register:(id)sender
{
    RegisterCommand *registerCmd = [[RegisterCommand alloc]initWithKey];
    registerCmd.type = [selectedUserTypeIndex intValue];
    registerCmd.email = self.emailTextField.text;
    registerCmd.password = self.passwordTextField.text;
    registerCmd.screenName = self.screenNameTextField.text;
    registerCmd.description = self.descriptionTextView.text;
    registerCmd.thumbnail = thumbnail;
    
    UserService *sharedUserService = [UserService sharedUserService];
    sharedUserService.delegate = self;
    [sharedUserService register:registerCmd];
}


- (IBAction)goBackToLogin:(id)sender
{
        LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginViewController animated:NO completion:nil];
}

- (IBAction)chooseThumbnail:(id)sender
{
    //[self performSegueWithIdentifier:@"ImagePickerSegue" sender:self];
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=TRUE;
    [self presentViewController:imagePickController animated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"registerMainSegue"])
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
    }
    else if([segue.identifier isEqualToString:@"ImagePickerSegue"])
    {
        UIImagePickerController *imagePickController = [segue destinationViewController];
        imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickController.delegate=self;
        imagePickController.allowsEditing=TRUE;
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    int imageSize = imageData.length/1024;
    
    NSLog(@"selected image size: %d kb", imageSize);
    
    if(imageSize > 300)
    {
        image = [ImageHelper imageWithImage:image scaledToSize:CGSizeMake(20, 20)];
        imageData = UIImagePNGRepresentation(image);
        imageSize = imageData.length/1024;
        
        NSLog(@"selected image size now is: %d kb", imageSize);
    }
    
    self.thumbnailImageView.image = image;
    
    thumbnail = [Base64 encode:imageData];
    NSLog(@"%@",thumbnail);
    
//    [[self.view viewWithTag:100023] removeFromSuperview];
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320/2-200/2, 10, 100, 100)];
//    imageView.tag = 100023;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.image = image;
//    [self.view addSubview:imageView];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) commandFailed:(id)command withError:(NSError *)error
{
    [self.spinner stopAnimating];
    
    [GuiHelper showError:error withTitle:@"Registration failed"];
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) registrationSucceded:(User *)user
{
    [self.spinner stopAnimating];
    NSLog(@"user %@ logged in", user.key);
    //MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    //[self presentViewController:mainViewController animated:NO completion:nil];
    [self performSegueWithIdentifier:@"registerMainSegue" sender:self];
}
@end
