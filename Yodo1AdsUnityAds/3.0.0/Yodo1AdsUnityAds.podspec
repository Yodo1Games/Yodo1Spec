Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsUnityAds'
    s.version          = '3.0.0'
    s.summary          = 'UnityAds of v2.2.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = "#{s.version}" +'/UnityAds.framework/Headers/*.h'

    s.public_header_files = "#{s.version}" +'/UnityAds.framework/Headers/*.h'
     
    s.vendored_frameworks = "#{s.version}" +'/UnityAds.framework'
    
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.libraries = 'sqlite3.0','z'
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'UIKit', 'Security','SystemConfiguration','CoreGraphics','CoreTelephony','CoreFoundation','AdSupport','AVFoundation'
end
