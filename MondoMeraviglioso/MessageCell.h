//
//  MessageCell.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 29/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *senderScreenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
