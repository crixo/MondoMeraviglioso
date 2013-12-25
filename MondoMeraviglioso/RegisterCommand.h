//
//  RegisterCommand.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RegisterCommand : NSObject

@property (nonatomic, strong) NSString *userKey;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumbnail;

- (RegisterCommand*)initWithKey;

@end
