//
//  LocalizationManager.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 02/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocalizationManager : NSObject <CLLocationManagerDelegate>

+ (id)sharedLocalizationManager;

- (CLLocation *) getMyCurrentLocation;

@end
