#
# Be sure to run `pod lib lint DCHFyberSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DCHFyberSDK"
  s.version          = "1.0.0"
  s.summary          = "DCHFyberSDK is a wrapper above Fyber API." 
  s.description      = "It is supposed to provide anything you need to have access to Fyber ADS engine by only adding the specific data such as API key provided by Fyber Team."

  s.homepage         = "https://github.com/dchirita/DCHFyberSDK"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel" => "dv.chirita@gmail.com" }
  s.source           = { :git => "https://github.com/dchirita/DCHFyberSDK.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '12.0'
  s.requires_arc = true

  s.public_header_files = 'Pod/Classes/DCHFyberOffersSDK.framework/Headers/*.h'
  s.source_files = "Pod/Classes/DCHFyberOffersSDK.framework/Headers/*.h"
  s.vendored_frameworks = "Pod/Classes/DCHFyberOffersSDK.framework"
  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
