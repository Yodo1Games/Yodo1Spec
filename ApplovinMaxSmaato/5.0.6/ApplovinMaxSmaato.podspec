Pod::Spec.new do |s|
    s.name             = 'ApplovinMaxSmaato'
    s.version          = '5.0.6'
    s.summary          = 'v '

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => 'https://github.com/Yodo1Games/Yodo1-SDK-iOS.git', :tag => "#{s.name}#{s.version}" }

    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    # s.source_files = [ "*.h" ]

    # s.public_header_files = [ "*.h" ]

    # s.vendored_libraries = [ "*.a" ]
    
    s.vendored_frameworks = ["*.framework"]

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
        'CoreMotion',
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
        'Security',
        'CoreBluetooth']

    s.weak_frameworks = [
        'AdSupport',
        'SafariServices',
        'ReplayKit',
        'CloudKit',
        'GameKit']

    s.libraries = [
        'sqlite3.0',
        'c++',
        'z']

    s.dependency 'smaato-ios-sdk/Full','21.6.2'
    s.dependency 'smaato-ios-sdk/Banner','21.6.2'
    s.dependency 'smaato-ios-sdk/Interstitial','21.6.2'
    s.dependency 'smaato-ios-sdk/RewardedAds','21.6.2'
    s.dependency 'smaato-ios-sdk/Native','21.6.2'
    s.dependency 'smaato-ios-sdk/InApp','21.6.2'

    s.dependency 'smaato-ios-sdk/Modules','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/Core','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/Banner','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/Native','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/Interstitial','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/UnifiedBidding','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/RewardedAds','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/RichMedia','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/Video','21.6.2'
    s.dependency 'smaato-ios-sdk/Modules/OpenMeasurement','21.6.2'

    s.dependency 'YD1ApplovinMax', '5.0.3'
end
