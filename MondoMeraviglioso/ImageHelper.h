//
//  ImageHelper.h
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 18/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
