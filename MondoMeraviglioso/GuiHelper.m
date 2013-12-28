//
//  GuiHelper.m
//  Engage Demo App
//
//  Created by WebPLU Team on 11/12/13.
//  Copyright (c) 2013 webplu. All rights reserved.
//

#import "GuiHelper.h"

@implementation GuiHelper

+ (void) showError:(NSError *)error withTitle:(NSString *)title
{
    NSString *errorMessage = [error localizedDescription];
    
    if(error.userInfo)
    {
        NSString *engageErrorDetails = [error.userInfo objectForKey:(@"ErrorDetails")];
        if(engageErrorDetails)
        {
            errorMessage = [NSString stringWithFormat:@"%@ : %@", errorMessage, engageErrorDetails];
        }
    }
    
    [GuiHelper showMessage:errorMessage withTitle:title];
}

+ (void) showMessage:(NSString *)text withTitle:(NSString *)title
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                         message:text
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [alert show];
}

@end
