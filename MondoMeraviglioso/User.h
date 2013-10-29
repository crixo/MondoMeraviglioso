//
//  User.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;

typedef enum UserType{
    Couple
} UserType;

@interface User : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, assign) UserType type;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) Location *location;

@end
