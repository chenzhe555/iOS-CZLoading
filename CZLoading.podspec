Pod::Spec.new do |s|
  s.name         = "CZLoading"
  s.version      = "0.0.1"
  s.summary      = "iOS-Loading"
  s.description  = "iOS-Loading "
  s.homepage     = "https://github.com/chenzhe555/iOS-CZLoading"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "chenzhe555" => "376811578@qq.com" }
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/chenzhe555/iOS-CZLoading.git", :tag => "#{s.version}" }
  s.public_header_files = 'CZLoading/CZLoading.h'
  s.source_files  = 'CZLoading/CZLoading.h'
  s.subspec 'CZLoading' do |one|
      one.source_files = 'CZLoading/classes/*.{h,m}'
  end
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
