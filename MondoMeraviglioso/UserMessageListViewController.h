//
//  UIUserMessageListViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserMessageListViewController : UIViewController
    @property (nonatomic, strong) User *user;
@end
