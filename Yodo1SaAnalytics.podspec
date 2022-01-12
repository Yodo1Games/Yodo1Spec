Pod::Spec.new do |s|
    s.name             = 'Yodo1SaAnalytics'
    s.version          = '6.0.0'
    s.summary          = '神策SDK 修复bitcode 的问题'

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

    s.source_files = ["*.framework/Headers/*.h"]

    s.public_header_files = ["*.framework/Headers/*.h"]
    
    # s.vendored_libraries = ["Yodo1Commons/*.a","Yodo1OnlineParameter/*.a"]

    s.vendored_frameworks = ["*.framework"]

    s.resources = ["*.bundle"]

    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = [
        'CoreTelephony',
        'SystemConfiguration']

    s.weak_frameworks = ['AdSupport']

    s.libraries = [
        'sqlite3.0',
        'c++',
        'z']

end
