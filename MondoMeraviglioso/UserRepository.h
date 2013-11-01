//
//  UserRepository.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class CLLocation;

@interface UserRepository : NSObject

- (User*) FindByEmail:(NSString *) email;
- (NSArray *) FindByLocation:(CLLocation*) location inARangeOf:(int) kilometers;

@end
