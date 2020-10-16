Pod::Spec.new do |s|
  s.name             = 'LBAppConfiguration'
  s.version          = '1.0.0'
  s.summary          = '项目需要集成的第三方库快速配置。'
  s.description      = '项目需要集成的第三方库快速配置，省去了其他一些复杂的代码，一键设置，更快更方便。'
  s.homepage         = 'https://github.com/A1129434577/LBAppConfiguration'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'A1129434577' => '1129434577@qq.com' }
  s.source           = { :git => 'https://github.com/A1129434577/LBAppConfiguration.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  
  s.subspec 'LBAppConfiguration' do |ss|
    ss.source_files = "LBAppConfiguration/LBAppConfiguration/**/*.{h,m}"
  end

  #s.default_subspec = 'Login'

  s.subspec 'Login' do |ss|
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.dependency 'JPush'
    ss.dependency 'LBUserInfo'
    ss.dependency 'LBCommonComponents'
    ss.source_files = "LBAppConfiguration/Login/**/*.{h,m}"
  end
  
  s.subspec 'JPush' do |ss|
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.dependency 'JPush'
    ss.source_files = "LBAppConfiguration/JPush/**/*.{h,m}"
  end

  s.subspec 'SDWebImage' do |ss|
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.dependency 'SDWebImageWebPCoder'
    ss.source_files = "LBAppConfiguration/SDWebImage/**/*.{h,m}"
  end
  
  s.subspec 'IQKeyboard' do |ss|
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.dependency 'IQKeyboardManager'
    ss.source_files = "LBAppConfiguration/IQKeyboard/**/*.{h,m}"
  end
  
  
end
#--use-libraries
