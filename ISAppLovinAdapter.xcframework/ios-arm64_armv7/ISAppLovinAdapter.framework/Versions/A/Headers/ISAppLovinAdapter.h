//
//  Copyright (c) 2015 IronSource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IronSource/ISBaseAdapter+Internal.h"
#import "IronSource/ISMetaData.h"


static NSString * const AppLovinAdapterVersion = @"4.3.29";
static NSString * GitHash = @"bb89bf5e8";

//System Frameworks For AppLovin Adapter

@import AdSupport;
@import AppTrackingTransparency;
@import AudioToolbox;
@import AVFoundation;
@import CFNetwork;
@import CoreGraphics;
@import CoreMedia;
@import CoreMotion;
@import CoreTelephony;
@import MessageUI;
@import SafariServices;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import WebKit;


@interface ISAppLovinAdapter : ISBaseAdapter

@end
