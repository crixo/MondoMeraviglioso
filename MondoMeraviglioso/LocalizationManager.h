//
//  LocalizationManager.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 02/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocalizationManagerDelegate

- (void) locationChanged:(CLLocation *)newLocation;

@end

@interface LocalizationManager : NSObject

+ (id)sharedLocalizationManager;


@property (strong, nonatomic) CLLocationManager *locationManager;

-(void) restart;

@end
