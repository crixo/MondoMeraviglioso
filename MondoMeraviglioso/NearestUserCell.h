//
//  NearestUserCell.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 25/11/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearestUserCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@end
