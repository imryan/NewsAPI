#
# Be sure to run `pod lib lint NewsAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NewsAPI'
  s.version          = '1.0.0'
  s.summary          = 'Swift wrapper for the News API service.'

  s.description      = <<-DESC
  Get breaking news headlines, and search for articles from news sources and blogs all over the web with the News API.
                       DESC

  s.homepage         = 'https://github.com/imryan/NewsAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'imryan' => 'notryancohen@gmail.com' }
  s.source           = { :git => 'https://github.com/imryan/NewsAPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/notryancohen'

  s.ios.deployment_target = '8.0'
  s.source_files = 'NewsAPI/Classes/**/*'
end
