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
#import "SBJsonWriter.h";

#include <math.h>
#define KmPerDegree		111.12000071117
#define	DegreesPerKm	(1.0/KmPerDegree)
#define PI				M_PI
#define TwoPI			(M_PI+M_PI)
#define HalfPI			M_PI_2
#define RadiansPerDegree	(PI/180.0)
#define	DegreesPerRadian	(180.0/PI)
#define copysign(x,y)		(((y)<0.0)?-fabs(x):fabs(x))
#define NGT1(x)		(fabs(x)>1.0?copysign(1.0,x):(x))
//#define ArcCos(x)	(fabs(x)>1?quiet_nan():acos(x)) //Hack
#define ArcCos(x)	(acos(x))
#define hav(x)		((1.0-cos(x))*0.5)		/* haversine */
#define ahav(x)		(ArcCos(NGT1(1.0-((x)*2.0))))	/* arc haversine */
#define sec(x)		(1.0/cos(x))			/* secant */
#define csc(x)		(1.0/sin(x))			/* cosecant */


@implementation UserService
{
    NSMutableArray *users;
    LocalizationManager *sharedLocationManager;
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
        restBaseUrl = @"http://www.webprofessor.it/mm";
        users= [NSMutableArray arrayWithObjects:
                [[User alloc]initWithMandatory:@"test1@wp.it" :@"test1" :Couple],
                [[User alloc]initWithMandatory:@"test2@wp.it" :@"test2" :Couple], nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

//- (void) setCurrentUser:(id)user
//{
//    _currentUser = user;
//    [sharedLocationManager.locationManager startUpdatingLocation];
//}


- (void) login:(LoginCommand *)loginCommand
{
    User *user = [self findByCredentials:loginCommand.email :loginCommand.password];
    if(user)
    {
        _currentUser = user;
        [sharedLocationManager.locationManager startUpdatingLocation];
        [self.delegate loginSucceded:user];
    }
    else
    {
        NSError *error =  [NSError errorWithDomain:@"myDomain" code:100 userInfo:nil];
        [self.delegate commandFailed:loginCommand withError:error];
    }
}

- (void) register:(RegisterCommand *)registerCommand
{
    User *user = [[User alloc]initWithMandatory:registerCommand.email :registerCommand.screenName :registerCommand.type];
    
    self.currentUser = user;
    
    [users addObject:user];
    
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
          :[self moveLocation :location :(500 * (i+1)) :(i%4 * 90)]]];
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

-(CLLocation*) moveLocation:(CLLocation*)startLocation:(double)movementInMeters:(double)movementBearing
{
	//http://iphonedevsdk.com/forum/iphone-sdk-development-advanced-discussion/36462-modifying-cllocations.html
	double	dist = (movementInMeters / 1000);	/* -> great-circle distance (km) */
	double	course = movementBearing;			/* -> initial great-circle course (degrees) */
	double	slt = startLocation.coordinate.latitude;	/* -> starting decimal latitude (-S) */
	double	slg = startLocation.coordinate.longitude;	/* -> starting decimal longitude(-W) */
	double	xlt = 0;	/* <- ending decimal latitude (-S) */
	double	xlg = 0;	/* <- ending decimal longitude(-W) */
	
	double	c, d, dLo, L1, L2, coL1, coL2, l;
    
	if (dist > KmPerDegree*180.0) {
		course -= 180.0;
		if (course < 0.0) course += 360.0;
		dist    = KmPerDegree*360.0-dist;
	}
	
	if (course > 180.0) course -= 360.0;
	c    = course*RadiansPerDegree;
	d    = dist*DegreesPerKm*RadiansPerDegree;
	L1   = slt*RadiansPerDegree;
	slg *= RadiansPerDegree;
	coL1 = (90.0-slt)*RadiansPerDegree;
	coL2 = ahav(hav(c)/(sec(L1)*csc(d))+hav(d-coL1));
	L2   = HalfPI-coL2;
	l    = L2-L1;
	if ((dLo=(cos(L1)*cos(L2))) != 0.0)
		dLo  = ahav((hav(d)-hav(l))/dLo);
	if (c < 0.0) dLo = -dLo;
	slg += dLo;
	if (slg < -PI)
		slg += TwoPI;
	else if (slg > PI)
		slg -= TwoPI;
    
	xlt = L2*DegreesPerRadian;
	xlg = slg*DegreesPerRadian;
    
	CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:xlt longitude:xlg];
	return tempLocation;
}

@end
