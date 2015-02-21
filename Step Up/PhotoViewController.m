//
//  PhotoViewController.m
//  Step Up
//
//  Created by Minh Luu on 2/20/15.
//  Copyright (c) 2015 Minh Luu. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setHidesBarsOnTap:YES];
    
    self.title = self.photo[@"name"];
    
    if ([self.cache objectForKey:self.photo[@"id"]]) {
        UIImage *cachedImage = [self.cache objectForKey:self.photo[@"id"]];
        self.imageView.image = cachedImage;
    } else {
        NSString *imageURLString = [self.photo[@"image_url"] lastObject];
        NSURLSession *urlSession = [NSURLSession sharedSession];
        [[urlSession dataTaskWithURL:[NSURL URLWithString:imageURLString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.cache setObject:image forKey:self.photo[@"id"]];
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                self.imageView.image = image;
            }];
        }] resume];
    }
    
    [self.navigationController addObserver:self forKeyPath:@"toolbarHidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setHidesBarsOnTap:NO];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@", change.description);
}

- (void)dealloc {

    [self.navigationController removeObserver:self forKeyPath:@"toolbarHidden"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
