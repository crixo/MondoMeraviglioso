//
//  ChooseImageViewController.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 28/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "ChooseImageViewController.h"
#import "ImageHelper.h"
#import "Base64.h"

@interface ChooseImageViewController ()

@end

@implementation ChooseImageViewController

-(void)presentImagePicker
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=TRUE;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickController];
        //[popover presentPopoverFromRect:self.selectedImageView.bounds inView:self.selectedImageView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popOver = popover;
    } else {
        [self presentViewController:imagePickController animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.popOver = Nil;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    int imageSize = imageData.length/1024;
    
    NSLog(@"selected image size: %d kb", imageSize);
    
    if(imageSize > 300)
    {
        image = [ImageHelper imageWithImage:image scaledToSize:CGSizeMake(20, 20)];
        imageData = UIImagePNGRepresentation(image);
        imageSize = imageData.length/1024;
        
        NSLog(@"selected image size now is: %d kb", imageSize);
    }
    
    self.imageView.image = image;
    
    self.thumbnail = [Base64 encode:imageData];
    NSLog(@"%@", self.thumbnail);
    
    //    [[self.view viewWithTag:100023] removeFromSuperview];
    //    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320/2-200/2, 10, 100, 100)];
    //    imageView.tag = 100023;
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    imageView.image = image;
    //    [self.view addSubview:imageView];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.popOver = Nil;
}

@end
