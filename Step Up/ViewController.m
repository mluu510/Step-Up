//
//  ViewController.m
//  Step Up
//
//  Created by Minh Luu on 2/20/15.
//  Copyright (c) 2015 Minh Luu. All rights reserved.
//

#import "ViewController.h"
#import <PXAPI/PXAPI.h>
#import "PhotoViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"500PX";
    self.cache = [[NSCache alloc] init];
    
    [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeatureFreshToday completion:^(NSDictionary *results, NSError *error) {
        self.photos = results[@"photos"];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = photo[@"name"];
    if ([photo[@"description"] isKindOfClass:NSString.class]) {
        cell.detailTextLabel.text = photo[@"description"];
    } else {
        cell.detailTextLabel.text = nil;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoViewController *photoVC = (PhotoViewController *)segue.destinationViewController;
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *photo = self.photos[indexPath.row];
    photoVC.photo = photo;
    photoVC.cache = self.cache;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
