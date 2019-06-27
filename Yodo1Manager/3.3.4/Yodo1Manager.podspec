Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '3.3.4'
    s.summary          = 'v3.3.4 - 2019-06-27
                            1.更新 Tapjoy v12.3.1
                            2.更新 IronSource v6.8.4.0
                            3.更新 Facebook v5.4.0
                            4.更新 Toutiao v2.2.0.0
                            5.更新 Chartboost v7.5.0
                            6.添加 测试设备功能 [在线参数]
                            7.添加 Yodo1 测试广告
                          '
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.subspec 'Yodo1_Manager' do |ss|
        ss.source_files = "#{s.version}" + "/*.{h,mm}"
        
        ss.vendored_libraries = "#{s.version}" + "/*.a"
        
        ss.public_header_files = "#{s.version}" + "/*.h"
        ss.preserve_path = "#{s.version}" + "/ChangeLog.txt"
        ss.resources = "#{s.version}" + "/Yodo1Ads.bundle"
        ss.requires_arc = true
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
        ss.dependency 'Yodo1KeyInfo','3.0.0'
        ss.dependency 'Yodo1Commons','3.0.4'
        ss.dependency 'Yodo1ZipArchive','3.0.0'
        ss.dependency 'Yodo1YYModel', '3.0.1'
        ss.dependency 'Yodo1Analytics','3.0.4'
        ss.dependency 'Yodo1ThirdsAnalytics','3.0.13'
        ss.dependency 'Yodo1AdsConfig','3.0.9'
        ss.dependency 'Yodo1Track','3.0.4'
        ss.dependency 'Yodo1FeedbackError','3.0.0'
        ss.dependency 'Yodo1SDWebImage','3.0.0'
        ss.dependency 'Yodo1OnlineParameter','3.0.3'
        ss.dependency 'Yodo1AdvertSDK','3.0.3'
        ss.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'
        ss.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit','CoreFoundation'
    end


    # s.subspec 'Yodo1_ConfigKey' do |ss|
    #     ss.resources = "#{s.version}" + '/Yodo1KeyConfig.bundle'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    #     ss.xcconfig = {
    #         "OTHER_LDFLAGS" => "-ObjC",
    #         "ENABLE_BITCODE" => "NO",
    #         "ONLY_ACTIVE_ARCH" => "NO"
    #     }
    # end

    # s.subspec 'Yodo1_UnityConfigKey' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
    #         "OTHER_LDFLAGS" => "-ObjC",
    #         "ENABLE_BITCODE" => "NO",
    #         "ONLY_ACTIVE_ARCH" => "NO"
    #     }
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

end
