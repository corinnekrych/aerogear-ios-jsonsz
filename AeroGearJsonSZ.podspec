Pod::Spec.new do |s|
  s.name         = "AeroGearJsonSZ"
  s.version      = "0.1.0"
  s.summary      = "Serialize Swift objects back-forth from their JSON representation the easy way"
  s.homepage     = "https://github.com/aerogear/aerogear-ios-jsonsz"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/aerogear/aerogear-ios-jsonsz.git', :branch => 'master'}
  s.platform     = :ios, 8.0
  s.source_files = 'AeroGearJsonSZ/*.{swift}'
end
