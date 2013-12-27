//
//  JsonClient.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 12/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonClient : NSObject

+ (id)sharedJsonClient;

-(void)get :(NSString*) actionUrl
    success:(void (^)(NSDictionary *jsonResult))success
    failure:(void (^)(NSError *error)) failure;

-(void)post :(NSDictionary*)jsonData to:(NSString*)actionUrl
     success:(void (^)(NSDictionary *jsonData))success
     failure:(void (^)(NSError *error))failure;

@end
