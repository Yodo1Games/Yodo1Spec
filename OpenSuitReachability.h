//
//  OpenSuitReachability.h
//
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OpenSuitReachabilityStatus) {
    OpenSuitReachabilityStatusNone  = 0, ///< Not Reachable
    OpenSuitReachabilityStatusWWAN  = 1, ///< Reachable via WWAN (2G/3G/4G)
    OpenSuitReachabilityStatusWiFi  = 2, ///< Reachable via WiFi
};

typedef NS_ENUM(NSUInteger, OpenSuitReachabilityWWANStatus) {
    OpenSuitReachabilityWWANStatusNone  = 0, ///< Not Reachable vis WWAN
    OpenSuitReachabilityWWANStatus2G = 2, ///< Reachable via 2G (GPRS/EDGE)       10~100Kbps
    OpenSuitReachabilityWWANStatus3G = 3, ///< Reachable via 3G (WCDMA/HSDPA/...) 1~10Mbps
    OpenSuitReachabilityWWANStatus4G = 4, ///< Reachable via 4G (eHRPD/LTE)       100Mbps
};

@interface OpenSuitReachability : NSObject

@property (nonatomic, readonly) SCNetworkReachabilityFlags flags;                           ///< Current flags.
@property (nonatomic, readonly) OpenSuitReachabilityStatus status;                                ///< Current status.
@property (nonatomic, readonly) OpenSuitReachabilityWWANStatus wwanStatus NS_AVAILABLE_IOS(7_0);  ///< Current WWAN status.
@property (nonatomic, readonly, getter=isReachable) BOOL reachable;                         ///< Current reachable status.

/// Notify block which will be called on main thread when network changed.
@property (nullable, nonatomic, copy) void (^notifyBlock)(OpenSuitReachability *reachability);

/// Create an object to check the reachability of the default route.
+ (instancetype)reachability;

@end

NS_ASSUME_NONNULL_END
