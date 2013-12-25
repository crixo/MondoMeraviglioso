//
//  RegisterViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 31/10/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSRadioButtonSetController.h"
#import "UserService.h"

@interface RegisterViewController : UIViewController<
UserServiceDelegate,
GSRadioButtonSetControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
