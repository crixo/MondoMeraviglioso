//
//  CreateMessageCommand.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "SendMessageCommand.h"
#import "DataHelper.h"

@implementation SendMessageCommand
- (SendMessageCommand*)initWithSenderKey:(NSString*)senderKey RecipientKey:(NSString*)recipientKey Title:(NSString*)title Body:(NSString*)body;
{
    self = [super init];
    
    self.messageKey = [DataHelper getUUID];
    self.senderKey = senderKey;
    self.recipientKey = recipientKey;
    self.title = title;
    self.body = body;
    
    return self;
}
@end
