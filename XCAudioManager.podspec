#
# Be sure to run `pod lib lint XCAudioManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCAudioManager'
  s.version          = '1.0.0'
  s.summary          = 'XCAudioManager.'
  
  s.description      = <<-DESC
  XCAudioManager 基于科大讯飞的语音阅读和语音识别功能
                       DESC

  s.homepage         = 'https://github.com/fanxiaocong/XCAudioManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanxiaocong' => '1016697223@qq.com' }
  s.source           = { :git => 'https://github.com/fanxiaocong/XCAudioManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.platform     = :ios
  s.source_files = [
    'XCAudioManager/Classes/*.{h,m}',
    'XCAudioManager/Classes/XFAudio/*.{h,m}'
  ]

  # 第三方 framework
  s.vendored_frameworks = 'XCAudioManager/Classes/XFAudio/iflyMSC.framework'

  s.frameworks = [
    'CoreTelephony',
    'SystemConfiguration'
  ]

  s.libraries = [
    'z',
    'c++'
  ]

  s.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'ONLY_ACTIVE_ARCH' => 'NO',
    'VALID_ARCHS' => 'arm64e',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64 arm64'
  }
end
