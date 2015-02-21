//
//  PhotoViewController.h
//  Step Up
//
//  Created by Minh Luu on 2/20/15.
//  Copyright (c) 2015 Minh Luu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic) NSDictionary *photo;
@property (strong, nonatomic) NSCache *cache;

@end
