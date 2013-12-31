//
//  UserMessage.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "Message.h"
#import "MessageUser.h"
#import "NSString+Utilities.h"

@implementation Message

- (Message*)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    self.key = [dic objectForKey:@"key"];
    self.sender = [[MessageUser alloc ]initWithUserKey:[dic objectForKey:@"senderKey"]
                                            AndScreenName:[dic objectForKey:@"senderScreenName"]];
    self.recipient = [[MessageUser alloc ]initWithUserKey:[dic objectForKey:@"recipientKey"]
                                                 AndScreenName:[dic objectForKey:@"recipientScreenName"]];
    self.title = [dic objectForKey:@"title"];
    self.body = [dic objectForKey:@"message"];
    
    NSString *sentAtAsString = [dic objectForKey:@"sentAt"];
    self.sentAt = [sentAtAsString toDate];
    
    NSString* readAtAsString = [dic objectForKey:@"readAt"];
    if(readAtAsString != (id)[NSNull null] && readAtAsString.length > 0)
    {
        self.readAt = [readAtAsString toDate];
    }
    
    self.thumbnail = [dic objectForKey:@"thumbnail"];
    
    return self;
}

@end
