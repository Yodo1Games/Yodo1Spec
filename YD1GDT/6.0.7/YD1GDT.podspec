Pod::Spec.new do |s|
    s.name             = 'YD1GDT'
    s.version          = '6.0.7'
    s.summary          = '4.13.10 优汇量统计版本【6.0.1】，6.0.2 是正常版本
                            4.13.11 优汇量统计版本【6.0.3】,6.0.5.1版本是优汇量统计版本
                            new:4.13.22,6.0.6.1优汇量统计版本 '

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

    s.vendored_libraries = [ "*.a" ]
    
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

    s.dependency 'Yodo1AdvertSDK','6.0.1'
    s.dependency 'GDTMobSDK', '4.13.32'
    # s.dependency 'AdsGDT','1.0.0'
end
