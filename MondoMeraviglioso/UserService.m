//
//  UserService.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//  Test github

#import "UserService.h"
#import "LoginCommand.h"
#import "User.h"
#import "UserRepository.h"

@implementation UserService

#pragma mark Singleton Methods

+ (id)sharedUserService {
    static UserService *sharedUserService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserService = [[self alloc] init];
    });
    return sharedUserService;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


- (void) login:(LoginCommand *)loginCommand
{
    UserRepository *sharedUserRepository = [UserRepository sharedUserRepository];
    User *user = [sharedUserRepository FindByCredentials:loginCommand.email :loginCommand.password];
    if(user)
    {
        [self.delegate loginSucceded:user];
    }
    else
    {
        NSError *error =  [NSError errorWithDomain:@"myDomain" code:100 userInfo:nil];
        [self.delegate commandFailed:loginCommand withError:error];
    }
}

@end
