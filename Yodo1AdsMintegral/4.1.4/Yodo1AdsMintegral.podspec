Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsMintegral'
    s.version          = '4.1.4'
    s.summary          = 'SDK v6.3.3'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files = [
        "#{s.version}" + '/*.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKReward.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKInterstitialVideo.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKBidding.framework/Versions/A/Headers/*.h'
    ]

    s.public_header_files = [
        "#{s.version}" + '/*.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKReward.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKInterstitialVideo.framework/Versions/A/Headers/*.h',
        # "#{s.version}" + '/MTGSDKBidding.framework/Versions/A/Headers/*.h'
    ]
    
    # s.vendored_libraries = "#{s.version}" + '/*.a'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.vendored_frameworks = [
        "#{s.version}" + '/*.framework',
        # "#{s.version}" + '/MTGSDKReward.framework',
        # "#{s.version}" + '/MTGSDKInterstitialVideo.framework',
        # "#{s.version}" + '/MTGSDKBidding.framework'
    ]
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = [
        'Accounts', 
        'AssetsLibrary',
        'AVFoundation', 
        'CoreTelephony',
        'CoreLocation',
        'CoreMotion' ,
        'CoreMedia', 
        'EventKit',
        'EventKitUI', 
        'iAd', 
        'ImageIO',
        'MobileCoreServices', 
        'MediaPlayer',
        'MessageUI',
        'MapKit',
        'Social',
        'StoreKit',
        'Twitter',
        'WebKit',
        'SystemConfiguration',
        'AudioToolbox',
        'Security'
    ]

    s.weak_frameworks = [
        'AdSupport',
        'SafariServices',
        'ReplayKit',
        'CloudKit',
        'GameKit'
    ]
    
    s.libraries = [
        'sqlite3',
        'z',
        'c++',
        'xml2'
    ]

end
