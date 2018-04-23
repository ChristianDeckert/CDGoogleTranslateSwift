Pod::Spec.new do |s|
  s.name         = "CDGoogleTranslateSwift"
  s.version      = "0.0.1"
  s.summary      = "A google translate wrapper written in Swift"
  s.description  = "A google translate wrapper written in Swift"
  s.homepage     = "https://github.com/ChristianDeckert/CDGoogleTranslateSwift"
  s.license      = "MIT"
  s.author             = { "Christian Deckert" => "christian.deckert@icloud.com" }

  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/ChristianDeckert/CDGoogleTranslateSwift.git", :tag => "#{s.version}" }

  s.default_subspec = 'Default'

  s.subspec 'Default' do |ss|
    ss.source_files = "Classes/**/*.{swift}"
  end
end
