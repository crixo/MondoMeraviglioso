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

@protocol LoginDelegate
- (void)loginSucceded:(User *)user;
- (void)loginFailed:(NSError *)error;
@end

@interface UserService : NSObject

+ (id)sharedUserService;

@property (weak, nonatomic) id<LoginDelegate> loginDelegate;

- (void) login:(LoginCommand *)loginCommand;



@end
