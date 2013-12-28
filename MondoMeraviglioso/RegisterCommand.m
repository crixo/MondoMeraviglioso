//
//  RegisterCommand.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "RegisterCommand.h"
#import "DataHelper.h"

@implementation RegisterCommand

- (RegisterCommand*)initWithKey
{
    self = [super init];
    
    self.userKey = [DataHelper getUUID];
    return self;
}

@end
