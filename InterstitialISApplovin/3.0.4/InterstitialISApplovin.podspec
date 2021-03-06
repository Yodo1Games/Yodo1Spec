Pod::Spec.new do |s|
    s.name             = 'InterstitialISApplovin'
    s.version          = '3.0.4'
    s.summary          = 'IronSource v6.8.3.0 和Applovin 插屏聚合互斥'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/interstitial/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files = "#{s.version}" + '/*.{h,m}'

    #s.public_header_files = "#{s.version}" + '/*.h'

    # s.vendored_libraries = "#{s.version}" + '/*.a'

    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.dependency 'InterstitialIronSource','3.0.22'
    s.dependency 'Yodo1IronSourceApplovin','3.0.3'

end
