Pod::Spec.new do |s|
    s.name             = 'Yodo1ApplovinMaxAdColony'
    s.version          = '3.0.1'
    s.summary          = 'Applovin sdk v6.10.1 AdColony v4.1.2'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'
    
    # s.source_files = "#{s.version}" + '/*.{h,m}'
    # s.public_header_files = "#{s.version}" + '/*.h'
    
    # s.resources = "#{s.version}" + '/*.bundle'
    # s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.vendored_frameworks = "#{s.version}" + '/*.framework'
    # s.vendored_libraries = "#{s.version}" + '/*.a',"#{s.version}" + '/Avid/*.a'
    
    # s.compiler_flags = '-Wdocumentation','-Wundeclared-selector'
    
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
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

    s.dependency 'Yodo1AdsApplovin','3.2.0'
    s.dependency 'Yodo1AdsAdColony','3.0.2'
    # s.libraries = 'c++'
end
