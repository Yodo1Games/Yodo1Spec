Pod::Spec.new do |s|
    s.name             = 'Yodo1Analytics'
    s.version          = '3.0.0'
    s.summary          = '修复有时候数组插入nil的BUG'

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

    s.source_files  = "#{s.version}" + '/*.h'
    
    s.public_header_files = "#{s.version}" + '/*.h'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'
    
    s.preserve_paths = "#{s.version}" + '/ChangeLog.txt'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
   
    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z'
    
    s.dependency 'Yodo1YYCache','3.0.0'
    s.dependency 'Yodo1AFNetworking','3.0.0'
    s.dependency 'Yodo1Reachability','3.0.0'
    s.dependency 'Yodo1OnlineParameter','3.0.0'
    s.dependency 'Yodo1GDCTimer','3.0.0'
    s.dependency 'Yodo1UDID','3.0.0'

end
