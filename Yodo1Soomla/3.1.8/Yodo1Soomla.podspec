Pod::Spec.new do |s|
    s.name             = 'Yodo1Soomla'
    s.version          = '3.1.8'
    s.summary          = '更新Soomla sdk v5.4.0 [大更新 去掉了各平台adapter] 支持iOS 13 暂时不支持Inmobi v7.4.0'

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

    s.source_files  = ["#{s.version}" + '/*.h']
    
    s.public_header_files = ["#{s.version}" + '/*.h']
    
    s.vendored_libraries = ["#{s.version}" + '/*.a']
    
    # s.preserve_paths = "#{s.version}" + '/ChangeLog.txt'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
   
    s.frameworks = [
        "JavaScriptCore",
        "WebKit",
        "StoreKit",
        "AdSupport"
    ]

    s.libraries = [
        "z",
        "sqlite3.0"
    ]
    
end
