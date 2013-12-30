//
//  UIUserMessageListViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserMessageListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *messages;
@end
