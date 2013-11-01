//
//  UserService.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class LoginCommand;
@class RegisterCommand;
@class UpdateCommand;


@protocol UserServiceDelegate
- (void)loginSucceded:(User *)user;
- (void)registrationSucceded:(User *)user;
- (void)updateSucceded:(User *)user;

- (void)commandFailed:(id)command withError:(NSError *)error;
@end

@interface UserService : NSObject

+ (id)sharedUserService;

@property (weak, nonatomic) id<UserServiceDelegate> delegate;

- (void) login:(LoginCommand *)loginCommand;

- (void) register:(RegisterCommand *)registerCommand;

- (void) update:(UpdateCommand *)updateCommand;



@end
