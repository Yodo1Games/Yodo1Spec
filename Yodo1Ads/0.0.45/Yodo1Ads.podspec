Pod::Spec.new do |s|
    s.name             = 'Yodo1Ads'
    s.version          = '0.0.45'
    # s.version          = '0.0.43'
    # s.version          = '6.1.0.1'
    s.summary          = '  修改TD在线参数  
                            添加优汇量统计测试test
                            最低支持iOS 10.0
                            广告:v3.16.0
                            大更改
                            修复IS里面的Unity广告bug
                            6.0.3.1是优汇量统计版本，6.0.3是正式版
                            ----------------------------------
                            更新QQ Sdk 分享
                            ---------------
                            6.0.4.1 是优汇量测试版本
                            6.0.5.1 是优汇量测试版本
                            6.1.0.1 是优汇量测试版本
                            ----------------------
                            更新GDT .a ，Soomla v6.8.4
                        '

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    s.license          = { :type => 'MIT', :file => "LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => 'https://github.com/Yodo1Games/Yodo1-SDK-iOS.git', :tag => "#{s.name}#{s.version}" }
    s.ios.deployment_target = '10.0'

    s.subspec 'Yodo1_Ads' do |ss|
        ss.source_files = [ "*.{h,mm,m}" ]
        
        ss.public_header_files = [ "*.h" ]

        ss.vendored_libraries = [ "*.a" ]

        ss.resources = [ "Yodo1Ads.bundle" ]

        # ss.vendored_frameworks = ["*.framework"]
        
        ss.requires_arc = true
        
        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }

        ss.frameworks = [
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
        'AppTrackingTransparency']

        ss.weak_frameworks = [
        'AdSupport',
        'SafariServices',
        'ReplayKit',
        'CloudKit',
        'GameKit']

        ss.libraries = [
        'sqlite3.0',
        'c++',
        'z']

        ss.dependency 'Yodo1AdvertSDK','6.0.6'
        ss.dependency 'Yodo1ThirdsAnalytics','6.1.2'
        ss.dependency 'Bugly','2.5.91'
        ss.dependency 'Yodo1Analytics','6.0.1'
        ss.dependency 'OpenSuitThirdsAnalytics', '1.0.8'
    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = [ "Yodo1KeyConfig.bundle" ]
        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iCloud','6.0.1'
        ss.dependency 'Yodo1GameCenter','6.0.8'
        ss.dependency 'OpenSuitShare','1.0.6'
        ss.dependency 'Yodo1iRate','6.0.0'
        ss.dependency 'Yodo1Replay','6.0.1'
        ss.dependency 'Yodo1Notification','6.0.1'
        ss.dependency 'Yodo1Privacy','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_UnityConfigKey' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iCloud','6.0.1'
        ss.dependency 'Yodo1GameCenter','6.0.8'
        ss.dependency 'OpenSuitShare','1.0.6'
        ss.dependency 'Yodo1iRate','6.0.0'
        ss.dependency 'Yodo1Replay','6.0.1'
        ss.dependency 'Yodo1Notification','6.0.1'
        ss.dependency 'Yodo1Privacy','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Analytics','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        #ss.dependency 'OpenSuitPayment','1.1.1'
        ss.dependency 'Yodo1UCenter','6.1.3'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'OpenSuitShare','1.0.6'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iRate','6.0.0'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1GameCenter','6.0.8'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iCloud','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Notification','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Replay','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'Yodo1_Privacy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'PRIVACY',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Privacy','6.0.1'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    #================OpenSuit Anaylitic============================
    s.subspec 'OpenSuit_AnalyticsAppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'OpenSuitAnalyticsAppsFlyer','1.1.7'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end
    s.subspec 'OpenSuit_AnalyticsFirebase' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'OpenSuitAnalyticsFirebase','1.0.7'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

    s.subspec 'OpenSuit_AnalyticsUmeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'OpenSuitAnalyticsUmeng','1.0.6'
        ss.dependency 'Yodo1Ads/Yodo1_Ads',"#{s.version}"
    end

end
