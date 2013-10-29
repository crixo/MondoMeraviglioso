//
//  CreateCommand.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CreateCommand : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, assign) UserType type;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) UIImage *thumbnail;

@end
