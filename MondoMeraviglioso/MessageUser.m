//
//  MessageRecipient.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "MessageUser.h"

@implementation MessageUser

-(MessageUser *)initWithUserKey :(NSString *)userKey AndScreenName:(NSString *)screenName
{
    self = [super init];
    
    self.userKey = userKey;
    self.screenName = screenName;
    
    return self;
}

@end
