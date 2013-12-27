//
//  JsonClient.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 12/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "JsonClient.h"
#import "SBJsonWriter.h"

@implementation JsonClient
{
    NSString *restBaseUrl;
    NSString *apiKey;
}

typedef void (^ Success)(NSDictionary*);
typedef void (^ Failure)(NSError *);

#pragma mark Singleton Methods

+ (id)sharedJsonClient {
    static JsonClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init
{
    if (self = [super init])
    {
#if TARGET_IPHONE_SIMULATOR
        restBaseUrl = @"http://mm";
#else
        restBaseUrl = @"http://www.webprofessor.it/mm";
#endif
    }
    
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void) get:(NSString *)actionUrl
    success:(void (^)(NSDictionary *))success
    failure:(void (^)(NSError *))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", restBaseUrl, actionUrl];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSLog(@"%@", urlString);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:apiKey forHTTPHeaderField:@"X-Api-Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error)
        {
            failure(error);
        }
        else
        {
            success( [self convertToDictionary:data] );
        }
    }];
}

-(void) post :(NSDictionary*)jsonData to:(NSString *)actionUrl
      success:(Success)success
      failure:(Failure)failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", restBaseUrl, actionUrl];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSLog(@"%@", urlString);
    
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *jsonPostBody = [jsonWriter stringWithObject:jsonData];
    
    NSLog(@"jsonPostBody: %@", jsonPostBody);
    NSData *requestData = [NSData dataWithBytes:[jsonPostBody UTF8String] length:[jsonPostBody length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:apiKey forHTTPHeaderField:@"X-Api-Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            [self handleResponse :actionUrl :response :data :error :(Success)success :(Failure)failure];
        }];
}


-(void) handleResponse :(NSString*) actionUrl :(NSURLResponse*)response :(NSData*)data :(NSError *)error
      :(Success)success
      :(Failure)failure
{
    if (response && [response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        int statusCode = [httpResponse statusCode];
        NSLog(@"JsonClient %@ - %d", actionUrl, statusCode);
        if (statusCode > 400 && !error)
        {
            NSString *httpError;
            if (data)
            {
                httpError = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            
            NSDictionary *errorInfo;
            errorInfo
            = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                                                  NSLocalizedString(@"Server returned status code %d: %@",@""),
                                                  statusCode, httpError]
                                          forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"Api error"
                                        code:statusCode
                                    userInfo:errorInfo];
        }
    }
    
    if (error)
    {
        NSLog(@"JsonClient error for %@: %@ %@", actionUrl, error, [error userInfo]);
        failure(error);
    }
    else
    {
        success( [self convertToDictionary:data] );
    }
}

- (NSDictionary *) convertToDictionary :(NSData *)data
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    NSLog(@"json response: %@", parsedObject);
    return parsedObject;
}

@end
