//
//  MessageService.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "MessageService.h"
#import "SendMessageCommand.h"
#import "JsonClient.h"
#import "Message.h"

@implementation MessageService
{
    JsonClient *jsonClient;
}

+ (id)shared {
    static MessageService *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared= [[self alloc] init];
    });
    return shared;
}

- (id)init
{
    if (self = [super init])
    {
        jsonClient = [JsonClient sharedJsonClient];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void) send:(SendMessageCommand *)command
                success:(void (^)())success
                ko:(void (^)(NSError *))ko
{
    NSMutableDictionary *jsonData= [[NSMutableDictionary alloc] init];
    [jsonData setObject:command.messageKey forKey:@"messageKey"];
    [jsonData setObject:command.recipientKey forKey:@"recipientKey"];
    [jsonData setObject:command.senderKey forKey:@"senderKey"];
    [jsonData setObject:command.title forKey:@"title"];
    [jsonData setObject:command.body forKey:@"body"];
    [jsonData setObject:command.thumbnail forKey:@"thumbnail"];
    
    [jsonClient post:jsonData to:@"user-message-create.php"
    success:^(NSDictionary *jsonResult)
     {
         NSLog(@"Message %@ sent", command.messageKey);
         success();
     }
    failure:^(NSError *error)
     {
         NSLog(@"Sending message %@ failed: %@", command.messageKey, [error localizedDescription]);
         ko(error);
     }];
}

-(void) getMessagesFor:(NSString *)userKey
               success:(void (^)(NSArray *messages))success ko:(void (^)(NSError *))ko
{
    [jsonClient get:@"user-message-list.php"
             success:^(NSDictionary *jsonResult)
     {
         NSLog(@"Getting messages for %@: %@", userKey, jsonResult);
         NSMutableArray *messages = [[NSMutableArray alloc]init];
         
         NSMutableArray *results = [jsonResult valueForKey:@"messages"];
         for (NSDictionary *msgJson in results) {
             [messages addObject:[[Message alloc] initWithDictionary:msgJson]];
         }
         
         success(messages);
     }
             failure:^(NSError *error)
     {
         NSLog(@"Getting messages for %@ failed: %@", userKey, [error localizedDescription]);
         ko(error);
     }];
}

@end
