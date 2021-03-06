#
# Be sure to run `pod lib lint HHKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HHKit'
  s.version          = '0.0.15'
  s.summary          = 'A short description of HHKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hutaol/HHKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry' => '1325049637@qq.com' }
  s.source           = { :git => 'https://github.com/hutaol/HHKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HHKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HHKit' => ['HHKit/Assets/*.png']
  # }
  s.resources   = 'HHKit/Assets/*.{png,xib,nib,bundle}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'Toast', '~> 4.0.0'
  s.dependency 'SPAlertController', '~> 4.0.0'
  s.dependency 'MBProgressHUD', '~> 1.2.0'
  s.dependency 'HXPhotoPicker', '~> 3.1.6'
  s.dependency 'HXPhotoPicker/SDWebImage', '~> 3.1.6'
  
end
