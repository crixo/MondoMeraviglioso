//
//  MessageRecipient.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageRecipient : NSObject
@property (nonatomic, strong) NSString *userKey;
@property (nonatomic, strong) NSString *screenName;

-(MessageRecipient *)initWithUserKey :(NSString *)userKey AndScreenName:(NSString *)screenName;
@end
