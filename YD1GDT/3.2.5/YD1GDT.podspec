Pod::Spec.new do |s|
    s.name             = 'YD1GDT'
    s.version          = '3.2.5'
    s.summary          = 'GDTMob[广点通] v4.11.3'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files = "#{s.version}" +'/*.{h,m}'

    #s.public_header_files = "#{s.version}" +'/*.h'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'
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
    s.dependency 'Yodo1AdvertSDK','3.1.0'
    s.dependency 'Yodo1ThirdsAnalytics','3.1.1'
    s.dependency 'Yodo1AdsGDT','3.2.1'
end
