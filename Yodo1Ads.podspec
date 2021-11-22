Pod::Spec.new do |s|
    s.name             = 'Yodo1Ads'
    s.version          = '0.0.13'#'6.0.5'#
    s.summary          = '    
                            添加优汇量统计测试
                            最低支持iOS 10.0
                            广告:v3.16.0
                            大更改
                            修复IS里面的Unity广告bug
                            6.0.3.1是优汇量统计版本，6.0.3是正式版
                            ----------------------------------
                            更新QQ Sdk 分享
                            ---------------
                            6.0.4.1 是优汇量测试版本
                            支持Swift 版本
                        '

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    s.license          = { :type => 'MIT', :file => "LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => 'https://github.com/Yodo1Games/Yodo1-SDK-iOS.git', :tag => "#{s.name}#{s.version}" }
    s.ios.deployment_target = '10.0'

   s.source_files = [ "*.{h,mm,m}" ]
        
        s.public_header_files = [ "*.h" ]

        s.vendored_libraries = [ "*.a" ]

        s.resources = [ "Yodo1Ads.bundle","Yodo1KeyConfig.bundle" ]

        # ss.vendored_frameworks = ["*.framework"]
        
        s.requires_arc = true
        
        s.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS,YODO1_ADS,YODO1_SPLASH',
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
        'AppTrackingTransparency',
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
        s.dependency 'Bugly','2.5.90'
        # s.dependency 'Yodo1Analytics','6.0.1'

end
