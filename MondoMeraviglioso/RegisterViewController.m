//
//  RegisterViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "RegisterViewController.h"
#import "MIRadioButtonGroup.h"
#import "User.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet MIRadioButtonGroup *userTypesRadioButtonGroup;

@end

@implementation RegisterViewController

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
    NSArray *options =[[NSArray alloc]
                       initWithObjects:[NSNumber numberWithInt:Couple], nil];
    MIRadioButtonGroup *group =[[MIRadioButtonGroup alloc]
                                initWithFrame:CGRectMake(0, 20, 320, 75)
                                andOptions:options andColumns:1];
    
    [self.userTypesRadioButtonGroup addSubview:group];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
