//
//  ChooseImageViewController.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popOver;

@property (nonatomic, strong) NSString *thumbnail;

@property (strong, nonatomic) UIImageView *imageView;

-(void)presentImagePicker;

@end
