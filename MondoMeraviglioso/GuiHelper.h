//
//  GuiHelper.h
//  Engage Demo App
//
//  Created by WebPLU Team on 11/12/13.
//  Copyright (c) 2013 webplu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuiHelper : NSObject
+ (void) showError:(NSError *)error withTitle:(NSString *)title;
+ (void) showMessage:(NSString *)text withTitle:(NSString *)title;
@end
