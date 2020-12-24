Pod::Spec.new do |s|
    s.name             = 'MasSdk'
    s.version          = '4.0.0-alpha'
    s.summary          = 'v4.0.0-alpha'
    
    customVersion    = "5.0.4"

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    s.license          = { :type => 'MIT', :file => "LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => 'https://github.com/Yodo1Games/Yodo1-SDK-iOS.git', :tag => "#{s.name}#{s.version}" }
    s.ios.deployment_target = '9.0'

    s.subspec 'MasSdk_iOS' do |ss|
        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Ads/Yodo1_ConfigKey', "#{s.customVersion}"
    end

    s.subspec 'MasSdk_Unity' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }

        ss.dependency 'Yodo1Ads/Yodo1_UnityConfigKey', "#{s.customVersion}"
    end

    # Admob
    s.dependency 'Yodo1Ads/Admob_AdColony', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_AppLovin', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_Facebook', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_Inmobi', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_IronSource', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_MyTarget', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_Tapjoy', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_UnityAds', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/Admob_Vungle', "#{s.customVersion}"
    # ApplovinMax
    s.dependency 'Yodo1Ads/ApplovinMax_AdColony', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Admob', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Amazon', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Facebook', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Fyber', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_GDT', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Inmobi', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_IronSource', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Mintegral', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_MyTarget', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Pangle', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Smaato', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Tapjoy', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_UnityAds', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Verizon', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Vungle', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/ApplovinMax_Yandex', "#{s.customVersion}"
    # Yodo1
    s.dependency 'Yodo1Ads/YD1_AdColony', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Admob', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Applovin', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_ApplovinMax', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Facebook', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_GDT', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Inmobi', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_IronSource', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Mintegral', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_MyTarget', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Pangle', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Smaato', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Tapjoy', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_UnityAds', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Vungle', "#{s.customVersion}"
    s.dependency 'Yodo1Ads/YD1_Yandex', "#{s.customVersion}"

end
