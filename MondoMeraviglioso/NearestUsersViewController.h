//
//  NearestUsersViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 25/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearestUsersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *nearestUsers;
@end
