//
//  ViewController.m
//  MyStoreApp
//
//  Created by Taylor Mott on 8/31/15.
//  Copyright (c) 2015 Mott Applications. All rights reserved.
//

#import "ViewController.h"
@import iAd;
#import "StoreViewController.h"
#import "PurchasedDataController.h"
#import "StorePurchaseController.h"

@interface ViewController () <ADBannerViewDelegate>

@property (strong, nonatomic) ADBannerView *adBannerView;
@property (strong, nonatomic) UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [StorePurchaseController sharedInstance];
    [PurchasedDataController sharedInstance];
    [self registerForPurchasedContentNotifications];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -50, self.adBannerView.frame.size.width, self.adBannerView.frame.size.height)];
    self.adBannerView.delegate = self;
    
    [self.view addSubview:self.adBannerView];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *storeButton = [[UIBarButtonItem alloc] initWithTitle:@"Store" style:UIBarButtonItemStylePlain target:self action:@selector(storeButtonTapped)];
    
    self.toolbar.items = @[storeButton];
    
    [self.view addSubview:self.toolbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([PurchasedDataController sharedInstance].adsRemoved) {
        [self removeAds];
    }
}



- (void)storeButtonTapped {
    StoreViewController *storeVC = [StoreViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:storeVC];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - IAP

- (void)registerForPurchasedContentNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAds) name:kPurchasedContentUpdated object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeAds {
    self.adBannerView.hidden = YES;
    self.adBannerView = nil;
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - AdBannerView Delegate Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    //where we want the ad to display
    [UIView animateWithDuration:1.0 animations:^{
        banner.frame = CGRectMake(0, 0, banner.frame.size.width, banner.frame.size.height);
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
