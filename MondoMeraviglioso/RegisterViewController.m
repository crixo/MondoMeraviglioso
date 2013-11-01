//
//  RegisterViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet GSRadioButtonSetController *userTypeRadioButtonSet;
- (IBAction)register:(id)sender;

@end

@implementation RegisterViewController{
    NSUInteger *selectedUserTypeIndex;
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
    selectedUserTypeIndex = &selectedIndex;
    NSLog(@"selected user type: %lu", (unsigned long)selectedIndex);
}

- (IBAction)register:(id)sender {
    UserType userType;
    
    if(selectedUserTypeIndex = 0)
    {
        userType = Couple;
    }
    
    NSLog(@"selected user type %d", userType);
}
@end
