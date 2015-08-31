//
//  ViewController.m
//  MyStoreApp
//
//  Created by Taylor Mott on 8/31/15.
//  Copyright (c) 2015 Mott Applications. All rights reserved.
//

#import "ViewController.h"
@import iAd;

@interface ViewController () <ADBannerViewDelegate>

@property (strong, nonatomic) ADBannerView *adBannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -50, self.adBannerView.frame.size.width, self.adBannerView.frame.size.height)];
    self.adBannerView.delegate = self;
    
    [self.view addSubview:self.adBannerView];
}

#pragma mark - AdBannerView Delegate Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    //where we want the ad to display
    [UIView animateWithDuration:1.0 animations:^{
        banner.frame = CGRectMake(0, 0, self.adBannerView.frame.size.width, self.adBannerView.frame.size.height);
    }];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    //where we want the ad to hide
    [UIView animateWithDuration:1.0 animations:^{
        banner.frame = CGRectMake(0, -50, banner.frame.size.width, banner.frame.size.height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
