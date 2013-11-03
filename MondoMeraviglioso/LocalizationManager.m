//
//  LocalizationManager.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 02/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "LocalizationManager.h"
#import <CoreLocation/CoreLocation.h>


@implementation LocalizationManager
{
    CLLocation* _currentLocation;
    CLLocationManager *_locationManager;
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
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        // We don't want to be notified of small changes in location,
        // preferring to use our last cached results, if any.
       _locationManager.distanceFilter = 50;
        //[_locationManager startUpdatingLocation];
        //[_locationManager startMonitoringSignificantLocationChanges];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void) start
{
    NSLog(@"locationManager -> start");
    [_locationManager startUpdatingLocation];
}


- (void) stop
{
    
    NSLog(@"locationManager -> stop");
    [_locationManager stopUpdatingLocation];
}

- (CLLocation*) getMyCurrentLocation
{
    return _currentLocation;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(oldLocation)
    {
        NSLog(@"Old location: %f, %f",
          oldLocation.coordinate.latitude,
          oldLocation.coordinate.longitude);
    }
    
    if (!oldLocation ||
        (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
         oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
            
            // To-do, add code for triggering view controller update
            NSLog(@"New location: %f, %f",
                  newLocation.coordinate.latitude,
                  newLocation.coordinate.longitude);
            
            _currentLocation = newLocation;
            [self.delegate locationChanged:newLocation];
        }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
