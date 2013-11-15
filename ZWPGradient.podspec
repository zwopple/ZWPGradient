Pod::Spec.new do |s|
  s.name = "ZWPGradient"
  s.summary = "Objective-C wrapper around CGGradientRef for iOS"
  
  s.version = "1.0.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.homepage = "https://github.com/zwopple/ZWPGradient"
  s.author = { "Zwopple | Creative Software" => "support@zwopple.com" }
  s.ios.deployment_target = "6.0"
  s.source = { :git => "https://github.com/zwopple/ZWPGradient.git", :tag => "1.0.0" }
  s.requires_arc = true
  s.source_files = "ZWPGradient/"
  s.frameworks = "UIKit"
  
end