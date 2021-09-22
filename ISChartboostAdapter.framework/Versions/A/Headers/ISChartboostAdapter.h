//
//  Copyright (c) 2015 IronSource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IronSource/ISBaseAdapter+Internal.h"
#import "IronSource/ISGlobals.h"

static NSString * const ChartboostAdapterVersion = @"4.3.8";
static NSString * GitHash = @"917b282c8";

//System Frameworks For Chartboost Adapter

@import AdSupport;
@import CoreGraphics;
@import Foundation;
@import StoreKit;
@import UIKit;
@import WebKit;

@interface ISChartboostAdapter : ISBaseAdapter

@end
