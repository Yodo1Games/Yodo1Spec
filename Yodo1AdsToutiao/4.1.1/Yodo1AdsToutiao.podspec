Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsToutiao'
    s.version          = '4.1.1'
    s.summary          = '头条sdk v2.9.0.7 fix bug [切换网络崩溃BUG]'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'
    s.source_files = "#{s.version}" + '/*.framework/Headers/*.h',
    s.public_header_files = "#{s.version}" + '/*.framework/Headers/*.h'
    s.resources = "#{s.version}" + '/*.bundle'
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    s.vendored_frameworks = "#{s.version}" + '/*.framework'
    
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }


    s.frameworks = ["UIKit",
                    "MapKit",
                    "WebKit",
                    "MediaPlayer",
                    "CoreLocation",
                    "AdSupport",
                    "CoreMedia",
                    "AVFoundation",
                    "CoreTelephony",
                    "StoreKit",
                    "SystemConfiguration",
                    "MobileCoreServices",
                    "CoreMotion",
                    "Accelerate"
                    ]
                    
 s.libraries = 'c++', 'resolv', 'z', 'sqlite3'
    # s.weak_frameworks = 'AdSupport'

    s.libraries = ["c++",
                    "resolv.9",
                    "z",
                    "sqlite3"
                    ]
end
