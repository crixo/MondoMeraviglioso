//
//  UserRepository.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 01/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "UserRepository.h"

@implementation UserRepository{
    NSArray *users;
    
}

- (UserRepository *) init{
    self = [super init];
   users= [NSArray arrayWithObjects:
           @"Red", @"Green", @"Blue", @"Yellow", nil];
    return self;
}

- (User*) FindByEmail:(NSString *)email{
    return nil;
}

-(NSArray*) FindByLocation:(CLLocation *)location inARangeOf:(int)kilometers{
    return nil;
}
@end
