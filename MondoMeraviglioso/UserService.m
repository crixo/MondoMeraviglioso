//
//  UserService.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//  Test github

#import "UserService.h"
#import "LoginCommand.h"
#import "User.h"
#import "UserRepository.h"
#import "RegisterCommand.h"
#import "LocalizationManager.h"
#import "SBJsonWriter.h"
#import "LocalizationHelper.h"
#import "JsonClient.h"

@implementation UserService
{
    NSMutableArray *users;
    LocalizationManager *sharedLocationManager;
    JsonClient *sharedJsonClient;
    
    NSString *restBaseUrl;
    NSString *apiKey;
}

#pragma mark Singleton Methods

+ (id)sharedUserService {
    static UserService *sharedUserService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserService = [[self alloc] init];
    });
    return sharedUserService;
}

- (id)init
{
    if (self = [super init])
    {
        sharedLocationManager = [LocalizationManager sharedLocalizationManager];
        sharedLocationManager.locationManager.delegate = self;
        
        sharedJsonClient = [JsonClient sharedJsonClient];
        
#if TARGET_IPHONE_SIMULATOR
        restBaseUrl = @"http://mm";
#else
        restBaseUrl = @"http://www.webprofessor.it/mm";
#endif
        
        users= [NSMutableArray arrayWithObjects:
                [[User alloc]initWithMandatory:@"test1@wp.it" :@"test1" :Couple],
                [[User alloc]initWithMandatory:@"test2@wp.it" :@"test2" :Couple], nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void) login:(LoginCommand *)loginCommand
{
    NSMutableDictionary *jsonData= [[NSMutableDictionary alloc] init];
    [jsonData setObject:loginCommand.email forKey:@"email"];
    [jsonData setObject:loginCommand.password forKey:@"pwd"];
    
    [sharedJsonClient post:jsonData to:@"user-login.php"
        success:^(NSDictionary *userData)
        {
            User* user = [[User alloc]initWithDictionary:userData];
            _currentUser = user;
            [sharedLocationManager.locationManager startUpdatingLocation];
            [self.delegate loginSucceded:user];
        }
        failure:^(NSError *error)
        {
            [self.delegate commandFailed:loginCommand withError:error];
        }];
}

- (void) register:(RegisterCommand *)registerCommand
{
    NSMutableDictionary *jsonData= [[NSMutableDictionary alloc] init];
    [jsonData setObject:registerCommand.userKey forKey:@"userKey"];
    [jsonData setObject:registerCommand.email forKey:@"email"];
    [jsonData setObject:registerCommand.password forKey:@"pwd"];
    [jsonData setObject:registerCommand.screenName forKey:@"screenName"];
    [jsonData setObject:registerCommand.description forKey:@"description"];
    [jsonData setObject:registerCommand.thumbnail forKey:@"thumbnail"];
    [jsonData setObject:[NSNumber numberWithInt:registerCommand.type] forKey:@"type"];
    
    [sharedJsonClient post:jsonData to:@"user-create.php"
                   success:^(NSDictionary *userData)
     {
         User* user = [[User alloc]initWithDictionary:jsonData];
         _currentUser = user;
         [sharedLocationManager.locationManager startUpdatingLocation];
         [self.delegate registrationSucceded:user];
     }
                   failure:^(NSError *error)
     {
         [self.delegate commandFailed:registerCommand withError:error];
     }];
    
}

- (void) GetByLocation:(CLLocation *)location inARangeOf:(int)kilometers success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableArray *nearestUsers = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [users count]; i++)
    {
        User *user = [users objectAtIndex:i];
        [nearestUsers addObject:
         [[User alloc]initWithLocation
            :user.email
            :user.screenName
            :user.type
          :[LocalizationHelper moveLocation :location :(500 * (i+1)) :(i%4 * 90)]]];
    }
    
    success(nearestUsers);
}

- (User*) findByCredentials:(NSString *)email :(NSString *)password
{
    for (User *user in users)
    {
        if([email isEqualToString:user.email])
        {
            return user;
        }
    }
    return nil;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (!self.currentUser.location || [self isPositionChanged:newLocation :oldLocation])
    {
        self.currentUser.location = newLocation;
        [self sendLocationToServer];
    }
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        NSLog(@"New location: %f, %f",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
    }
    else
    {
        NSLog(@"App is backgrounded. New location is %@", newLocation);
    }
}

-(BOOL) isPositionChanged:(CLLocation *)newLocation :(CLLocation *)oldLocation
{
    return !oldLocation ||
    (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
     oldLocation.coordinate.longitude != newLocation.coordinate.longitude);
}

-(void) sendLocationToServer
{

    
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
    
    NSLog(@"Sending user %@ ts=%@ location to server: %f, %f",
          self.currentUser.key,
          localDateString,
          self.currentUser.location.coordinate.latitude,
          self.currentUser.location.coordinate.longitude);
    
    NSMutableDictionary *jsonData= [[NSMutableDictionary alloc] init];
    [jsonData setObject:self.currentUser.key forKey:@"userKey"];
    [jsonData setObject:localDateString forKey:@"ts"];
    [jsonData setObject:[NSString stringWithFormat:@"%f", self.currentUser.location.coordinate.latitude] forKey:@"latitude"];
    [jsonData setObject:[NSString stringWithFormat:@"%f", self.currentUser.location.coordinate.longitude] forKey:@"longitude"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/update-user-location4.php", restBaseUrl];
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
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
    }];
    
}

@end
