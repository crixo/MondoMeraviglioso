//
//  NSDate+Formatting.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "NSDate+Formatting.h"

@implementation NSDate(Formatting)

-(NSString*) toLocal
{
    NSDate *utcDate = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
   return [df stringFromDate:utcDate];
}

@end
