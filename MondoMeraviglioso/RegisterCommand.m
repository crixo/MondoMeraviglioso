//
//  RegisterCommand.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "RegisterCommand.h"
#import "User.h"

@implementation RegisterCommand

- (RegisterCommand*)initWithKey
{
    self = [super init];
    
    self.userKey = [User getUUID];
    return self;
}

@end
