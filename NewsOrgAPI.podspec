Pod::Spec.new do |s|
  s.name             = 'NewsOrgAPI'
  s.version          = '1.0.0'
  s.summary          = 'Swift wrapper for the News API service.'

  s.description      = <<-DESC
  Get breaking news headlines, and search for articles from news sources and blogs all over the web with the News API.
                       DESC

  s.homepage         = 'https://github.com/imryan/NewsAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ryan Cohen' => 'notryancohen@gmail.com' }
  s.source           = { :git => 'https://github.com/imryan/NewsAPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/notryancohen'
  s.swift_version = '5.1'
  s.ios.deployment_target = '9.3'
  s.source_files = 'NewsAPI/Classes/**/*'
end
