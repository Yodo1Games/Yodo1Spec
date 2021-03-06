Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsMintegral'
    s.version          = '3.0.3'
    s.summary          = '2018.12.19 -- Mintegral v4.8.0 (Mintegral 插屏视频版本)'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = "#{s.version}" + '/MTGSDK.framework/Versions/A/Headers/*.h',"#{s.version}" + '/MTGSDKReward.framework/Versions/A/Headers/*.h',"#{s.version}" + '/MTGSDKInterstitialVideo.framework/Versions/A/Headers/*.h'

    s.public_header_files = "#{s.version}" + '/MTGSDK.framework/Versions/A/Headers/*.h',"#{s.version}" + '/MTGSDKReward.framework/Versions/A/Headers/*.h',"#{s.version}" + '/MTGSDKInterstitialVideo.framework/Versions/A/Headers/*.h'
    
    # s.vendored_libraries = "#{s.version}" + '/*.a'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.vendored_frameworks = "#{s.version}" + '/MTGSDK.framework',"#{s.version}" + '/MTGSDKReward.framework',"#{s.version}" + '/MTGSDKInterstitialVideo.framework'

    s.requires_arc = false

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z','c++','xml2'
end
