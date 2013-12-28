//
//  CreateMessageCommand.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendMessageCommand : NSObject
@property (nonatomic, strong) NSString *messageKey;
@property (nonatomic, strong) NSString *senderKey;
@property (nonatomic, strong) NSString *recipientKey;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *thumbnail;

- (SendMessageCommand*)initWithSenderKey:(NSString*)senderKey RecipientKey:(NSString*)recipientKey Title:(NSString*)title Body:(NSString*)body;
@end
