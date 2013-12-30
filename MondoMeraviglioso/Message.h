//
//  UserMessage.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageUser;

@interface Message : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) MessageUser *sender;
@property (nonatomic, strong) MessageUser *recipient;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSDate *sentAt;
@property (nonatomic, strong) NSDate *readAt;
@property (nonatomic, strong) NSString *thumbnail;

- (Message*)initWithDictionary:(NSDictionary*)dic;
@end
