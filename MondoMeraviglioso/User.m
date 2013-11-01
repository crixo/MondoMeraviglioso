//
//  User.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "User.h"

@implementation User

- (User*)initWithMandatory:(NSString*)email :(NSString*)screenName :(UserType)type
{
    self = [super init];
    self.email = email;
    self.screenName = screenName;
    self.type = type;
    return self;
}


@end
