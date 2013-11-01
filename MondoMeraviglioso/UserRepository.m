//
//  UserRepository.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserRepository.h"

#import "User.h"

@implementation UserRepository
{
    NSArray *users;
    
}

#pragma mark Singleton Methods

+ (id)sharedUserRepository
{
    static UserRepository *sharedUserRepository = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserRepository = [[self alloc] init];
    });
    return sharedUserRepository;
}

- (id)init
{
    if (self = [super init])
    {
        users= [NSArray arrayWithObjects:
                [[User alloc]initWithMandatory:@"test1@wp.it" :@"test1" :Couple],
                [[User alloc]initWithMandatory:@"test2@wp.it" :@"test2" :Couple], nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (User*) FindByEmail:(NSString *)email
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

- (User*) FindByCredentials:(NSString *)email :(NSString *)password
{
    return [self FindByEmail:email];
}

-(NSArray*) FindByLocation:(CLLocation *)location inARangeOf:(int)kilometers
{
    return nil;
}
@end
