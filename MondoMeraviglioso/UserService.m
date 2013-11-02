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
#import "RegisterCommand.h"
#import "LocalizationManager.h"

@implementation UserService
{
    NSMutableArray *users;
}

#pragma mark Singleton Methods

+ (id)sharedUserService {
    static UserService *sharedUserService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserService = [[self alloc] init];
    });
    return sharedUserService;
}

- (id)init
{
    if (self = [super init])
    {
        users= [NSMutableArray arrayWithObjects:
                [[User alloc]initWithMandatory:@"test1@wp.it" :@"test1" :Couple],
                [[User alloc]initWithMandatory:@"test2@wp.it" :@"test2" :Couple], nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


- (void) login:(LoginCommand *)loginCommand
{
    User *user = [self findByCredentials:loginCommand.email :loginCommand.password];
    if(user)
    {
        LocalizationManager *sharedLocationManager = [LocalizationManager sharedLocalizationManager];
        user.location = [sharedLocationManager getMyCurrentLocation];
        [self.delegate loginSucceded:user];
    }
    else
    {
        NSError *error =  [NSError errorWithDomain:@"myDomain" code:100 userInfo:nil];
        [self.delegate commandFailed:loginCommand withError:error];
    }
}

- (void) register:(RegisterCommand *)registerCommand
{
    User *user = [[User alloc]initWithMandatory:registerCommand.email :registerCommand.screenName :registerCommand.type];
    LocalizationManager *sharedLocationManager = [LocalizationManager sharedLocalizationManager];
    user.location = [sharedLocationManager getMyCurrentLocation];
    
    [users addObject:user];
    
}

- (User*) findByCredentials:(NSString *)email :(NSString *)password
{
    for (User *user in users)
    {
        if([email isEqualToString:user.email])
        {
            return user;
        }
    }
    return nil;
}

@end
