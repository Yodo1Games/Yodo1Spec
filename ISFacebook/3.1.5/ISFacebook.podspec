Pod::Spec.new do |s|
    s.name             = 'ISFacebook'
    s.version          = '3.1.5'
    s.summary          = 'Facebook SDK 和Adapter 分离'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ISource/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    # s.source_files = "#{s.version}" + '/ISFacebookAdapter.framework/Versions/A/Headers/*.h'

    # s.public_header_files = "#{s.version}" + '/ISFacebookAdapter.framework/Versions/A/Headers/*.h'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    # s.vendored_frameworks = "#{s.version}" + '/ISFacebookAdapter.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z'
    
    s.dependency 'YD1IronSource','3.1.5'

    s.dependency 'Yodo1IronSourceFacebook','3.0.3'
    
end
