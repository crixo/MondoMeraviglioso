//
//  LocalizationHelper.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocalizationHelper : NSObject

+(CLLocation*) moveLocation:(CLLocation*)startLocation :(double)movementInMeters :(double)movementBearing;

@end
