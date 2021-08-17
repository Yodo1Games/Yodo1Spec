Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsInmobi'
    s.version          = '6.0.0'
    s.summary          = 'v9.2.0 '

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

    s.source_files = [ "*.framework/Headers/*.h" ]

    s.public_header_files = [ "*.framework/Headers/*.h" ]

    # s.vendored_libraries = [ "*.a" ]
    
    # s.resources = ["*.bundle"]

    s.vendored_frameworks = ["*.framework"]

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
        'VideoToolbox',
        'CoreBluetooth']

    s.weak_frameworks = [
        'AdSupport',
        'SafariServices',
        'ReplayKit',
        'CloudKit',
        'Accelerate',
        'GameKit']

    s.libraries = [
        'sqlite3.0',
        'c++',
        'stdc++',
        'xml2',
        'z']
    
end
