//
//  NSString+Utilities.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString(Utilities)



-(NSDate *) toDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:self];
}

@end
