//
//  MessageService.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SendMessageCommand;
@class Message;


@interface MessageService : NSObject

+ (id)shared;

- (void) send:(SendMessageCommand*) command
             success:(void (^)())success
                  ko:(void (^)(NSError *error)) ko;

- (void) getMessageByKey:(NSString*) key
                success:(void (^)(Message *message))success
                     ko:(void (^)(NSError *error)) ko;

- (void) getMessagesFor:(NSString*) userKey
      success:(void (^)(NSArray *messages))success
           ko:(void (^)(NSError *error)) ko;

- (void) getMessagesSentBy:(NSString*) userKey
                success:(void (^)(NSArray *messages))success
                     ko:(void (^)(NSError *error)) ko;
@end
