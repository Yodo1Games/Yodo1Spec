Pod::Spec.new do |s|
    s.name             = 'ApplovinMaxFacebook'
    s.version          = '3.2.1'
    s.summary          = 'v6.11.1 更新Facebook的adapter v5.6.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ApplovinMax/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files = "#{s.version}" +'/*.{h,m}'
    #s.public_header_files = "#{s.version}" +'/*.h'

    # s.vendored_libraries = "#{s.version}" + '/*.a'
    s.vendored_frameworks = "#{s.version}" + '/*.framework'
    s.requires_arc = true



    valid_archs = ['armv7', 'x86_64', 'arm64']

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO',
        'VALID_ARCHS' =>  valid_archs.join(' '),
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
        'CoreBluetooth'
    ]

    s.dependency 'YD1ApplovinMax','3.2.6'
    s.dependency 'Yodo1AdsFacebook','3.1.4'
end
