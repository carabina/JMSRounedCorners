Pod::Spec.new do |s|

  s.name          = "JMSRounedCorners"
  s.version       = "1.0.1"
  s.license       = "MIT"
  s.summary       = "The Swift version of UIView and UIImageView draw the rounded corners."
  s.homepage      = "https://github.com/James-swift/JMSRounedCorners"
  s.author        = { "xiaobs" => "1007785739@qq.com" }
  s.source        = { :git => "https://github.com/James-swift/JMSRounedCorners.git", :tag => "1.0.1" }
  s.requires_arc  = true
  s.description   = <<-DESC
                   JMSRounedCorners - The Swift version of UIView and UIImageView draw the rounded corners.
                   DESC
  s.source_files  = "JMSRounedCorners/Lib/*"
  s.platform      = :ios, '8.0'
  s.framework     = 'Foundation', 'UIKit'  

end
