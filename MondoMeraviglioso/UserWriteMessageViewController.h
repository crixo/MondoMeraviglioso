//
//  UserWriteMessageViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 27/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageUser;
#import "ChooseImageViewController.h"

@interface UserWriteMessageViewController : ChooseImageViewController
@property (nonatomic, strong) MessageUser *messageRecipient;
@end
