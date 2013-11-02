//
//  MainViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 02/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "MainViewController.h"
#import "LocalizationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myCurrentLocationLabel;
- (IBAction)getCurrentLocation:(id)sender;

@end

@implementation MainViewController

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

- (IBAction)getCurrentLocation:(id)sender
{
    LocalizationManager *sharedLocationManager = [LocalizationManager sharedLocalizationManager];
    CLLocation *currentLocation = [sharedLocationManager getMyCurrentLocation];
    self.myCurrentLocationLabel.text = [NSString stringWithFormat:@"Here I'm: %f, %f",
                                                         currentLocation.coordinate.latitude,
                                                         currentLocation.coordinate.longitude];
}
@end
