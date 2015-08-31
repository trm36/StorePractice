//
//  PurchasedDataController.h
//  MyStoreApp
//
//  Created by Taylor Mott on 8/31/15.
//  Copyright (c) 2015 Mott Applications. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kPurchasedContentUpdated = @"kPurchasedContentUpdated";

@interface PurchasedDataController : NSObject

@property (assign, nonatomic, readonly) BOOL adsRemoved;
//@property (strong, nonatomic, readonly) NSNumber *goldCoins;

+ (PurchasedDataController *)sharedInstance;

@end
