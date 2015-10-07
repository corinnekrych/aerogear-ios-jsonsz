Pod::Spec.new do |s|
  s.name         = "AeroGearJsonSZ"
  s.version      = "0.3.0"
  s.summary      = "Serialize Swift objects back-forth from their JSON representation the easy way"
  s.homepage     = "https://github.com/aerogear/aerogear-ios-jsonsz"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/aerogear/aerogear-ios-jsonsz.git', :tag => s.version }
  s.platform     = :ios, 8.0
  s.source_files = 'AeroGearJsonSZ/*.{swift}'
  s.requires_arc = true  
end
