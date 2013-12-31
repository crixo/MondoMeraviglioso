//
//  User.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "User.h"
#import "DataHelper.h"
#import "Base64.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+Utilities.h"

@implementation User

- (User*)initWithMandatory:(NSString*)email :(NSString*)screenName :(int)type
{
    self = [super init];
    
    self.key = [DataHelper getUUID];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    return self;
}

- (User*)initWithLocation:(NSString*)email :(NSString*)screenName :(int)type :(CLLocation *) location
{
    self = [super init];
    self.key = [DataHelper getUUID];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    self.location = location;
    return self;
}

- (User*)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    self.key = [dic objectForKey:@"key"];
    self.email = [dic objectForKey:@"email"];
    self.screenName = [dic objectForKey:@"screenName"];
    
    NSString *thumbnail = [dic objectForKey:@"thumbnail"];
    if(thumbnail != (id)[NSNull null] && thumbnail.length > 0)
    {
        [Base64 initialize];
        NSData * data = [Base64 decode:thumbnail];
        self.thumbnail  = [UIImage imageWithData:data];
    }
    
    NSNumber *lat = [dic objectForKey:@"lat"];
    NSNumber *lon = [dic objectForKey:@"lon"];
    if(lat!=Nil && lon!=Nil)
    {
        self.location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
    }
    
    NSNumber *num = [dic objectForKey:@"type"];
    self.type = [num intValue];
    
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



@end
