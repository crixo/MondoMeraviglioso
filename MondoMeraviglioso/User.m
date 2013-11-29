//
//  User.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "User.h"
#import <CoreLocation/CoreLocation.h>

@implementation User

- (User*)initWithMandatory:(NSString*)email :(NSString*)screenName :(UserType)type
{
    self = [super init];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    return self;
}

- (User*)initWithLocation:(NSString*)email :(NSString*)screenName :(UserType)type :(CLLocation *) location
{
    self = [super init];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    self.location = location;
    return self;
}

-(CLLocationDistance) getDistanceFrom:(User *)user
{
    NSLog(@"self.location: %f, %f",
          self.location.coordinate.latitude,
          self.location.coordinate.longitude);
    
    NSLog(@"user.location: %f, %f",
          user.location.coordinate.latitude,
          user.location.coordinate.longitude);
    
    return [self.location distanceFromLocation:user.location];
}

@end
