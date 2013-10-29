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
- (void)LoginSucceded:(User *)user;
- (void)LoginFailed:(NSError *)error;
@end

@interface UserService : NSObject

@property (weak, nonatomic) id<LoginDelegate> loginDelegate;

- (void) Login:(LoginCommand *)loginCommand;

@end
