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

- (User*)initWithMandatory:(NSString*)email :(NSString*)screenName :(int)type
{
    self = [super init];
    
    self.key = [User getUUID];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    return self;
}

- (User*)initWithLocation:(NSString*)email :(NSString*)screenName :(int)type :(CLLocation *) location
{
    self = [super init];
    self.key = [User getUUID];
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

+(NSString*)getTypeAsString:(int)type
{
    switch (type) {
        case 1:
            return NSLocalizedString(@"SingleMan", @"Single Man");
        case 2:
            return NSLocalizedString(@"SingleWomen", @"Single Women");
            
        default:
            return NSLocalizedString(@"Couple", @"Couple");
    }
}

+(NSString *)getUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    return uuidString;
}

@end
