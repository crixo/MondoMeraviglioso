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
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
