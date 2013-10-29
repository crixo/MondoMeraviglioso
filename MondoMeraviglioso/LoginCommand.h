//
//  LoginCommand.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginCommand : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@end
