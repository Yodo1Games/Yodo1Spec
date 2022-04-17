Pod::Spec.new do |s|
    s.name             = 'Yodo1OnlineParameter'
    s.version          = '6.0.3'
    s.summary          = '修复关闭广告之后崩溃的BUG,修改替换神策统计为数数统计/测试Tag'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    # s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }

    s.source           = { :git => 'https://github.com/Yodo1Games/Yodo1-SDK-iOS.git', :tag => "#{s.name}#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files = [
        "Yodo1AFNetworking/*.{h,m}",
        "Yodo1GDCTimer/*.{h,m}",
        "Yodo1KeyInfo/*.{h,m}",
        "Yodo1OnlineParameter/*.{h,m,mm}",
        "Yodo1Reachability/*.{h,m}",
        "Yodo1YYCache/*.{h,m}",
        "Yodo1YYModel/*.{h,m}",
        "Yodo1Commons/*.{h,m,mm}"]

    s.public_header_files = [
        "Yodo1AFNetworking/*.h",
        "Yodo1GDCTimer/*.h",
        "Yodo1KeyInfo/*.h",
        "Yodo1OnlineParameter/*.h",
        "Yodo1Reachability/*.h",
        "Yodo1YYCache/*.h",
        "Yodo1YYModel/*.h",
        "Yodo1Commons/*.h"]
    
    s.vendored_libraries = ["Yodo1Commons/*.a","Yodo1OnlineParameter/*.a"]

    # s.vendored_frameworks = ["Yodo1SaAnalytics/*.framework"]

    # s.resources = ["Yodo1SaAnalytics/*.bundle"]

    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
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
    # s.dependency 'Yodo1SaAnalytics', '6.0.0'

end
