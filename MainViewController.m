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
#import <MapKit/MapKit.h>
#import "UserService.h"
#import "User.h"
#import "NearestUsersViewController.h"
#import "UserMessageListViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *userMessageListButton;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)refresh:(id)sender;

@end

#define METERS_PER_MILE 1609.344

@implementation MainViewController
{
    NSArray *mappedUsers;
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
    //self.navigationItem.hidesBackButton = YES;
    [self.mapView setShowsUserLocation:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [self showMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"NearestUsersSegue"]){
        NearestUsersViewController *nearestUsersVewController = segue.destinationViewController;
        nearestUsersVewController.nearestUsers = mappedUsers;
    }else if([segue.identifier isEqualToString:@"UserMessageListSegue"]){
            UserMessageListViewController *userMessageListViewController = segue.destinationViewController;
    }
}

- (IBAction)refresh:(id)sender {
    // 1
    MKCoordinateRegion mapRegion = [self.mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    [self showMap];
}

- (void)showMap
{
    int range = 5;
    
    //45.074917,7.680261
    LocalizationManager *sharedLocalizationManager = [LocalizationManager sharedLocalizationManager];
    CLLocation *myCurrentLocation = sharedLocalizationManager.locationManager.location;
    
    // 1
    CLLocationCoordinate2D zoomLocation = myCurrentLocation.coordinate;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, range*METERS_PER_MILE, range*METERS_PER_MILE);
    
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
    
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    UserService *userService = [UserService sharedUserService];
    [userService GetByLocation:myCurrentLocation inARangeOf:range
           success:^(NSArray *users) {
               mappedUsers = users;
               for (User *user in users) {
                   MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                   annotation.coordinate = user.location.coordinate;
                   [self.mapView addAnnotation:annotation];
                   NSLog(@"user %@ is at %f, %f",
                         user.email,
                         user.location.coordinate.latitude,
                         user.location.coordinate.longitude);
               }
    }
                       failure:nil];
}


@end
