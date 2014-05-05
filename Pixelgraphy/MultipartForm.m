//
//  MultipartForm.m
//  Pixelgraphy
//
//  Created by ODESSA on 5/5/14.
//  Copyright (c) 2014 Laerte Sousa Neto. All rights reserved.
//

#import "MultipartForm.h"

@implementation MultipartForm

+(MultipartForm*)initWithURL:(NSURL*)url
{
    MultipartForm* newForm=[[MultipartForm alloc]init];
    //[newForm setPageURL:url];
    
    return newForm;
}

@end
