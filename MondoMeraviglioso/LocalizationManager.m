//
//  LocalizationManager.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 02/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "LocalizationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "UserService.h"
#import "User.h"


@implementation LocalizationManager
{
    CLLocation* _currentLocation;
}
#pragma mark Singleton Methods

+ (id)sharedLocalizationManager
{
    static LocalizationManager *localizationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localizationManager = [[self alloc] init];
    });
    return localizationManager;
}

- (id)init
{
    if (self = [super init])
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        // We don't want to be notified of small changes in location,
        // preferring to use our last cached results, if any.
       _locationManager.distanceFilter = 50;
        [_locationManager startUpdatingLocation];
        //[_locationManager startMonitoringSignificantLocationChanges];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void) restart
{
    NSLog(@"locationManager -> restart");
    [_locationManager stopUpdatingLocation];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    UserService *userService = [UserService sharedUserService];
    User *user = userService.currentUser;
    user.location = newLocation;
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        NSLog(@"New location: %f, %f",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
        
        if (!oldLocation ||
            (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
             oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
        {
            [self.delegate locationChanged:newLocation];
        }
        
    }
    else
    {
        NSLog(@"App is backgrounded. New location is %@", newLocation);
    }
    
    if(oldLocation)
    {
        NSLog(@"Old location: %f, %f",
          oldLocation.coordinate.latitude,
          oldLocation.coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
