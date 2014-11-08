Pod::Spec.new do |s|
  s.name         = "AQSActionMessageActivity"
  s.version      = "0.1.0"
  s.summary      = "[iOS] UIActivity Class for Message that appears in Action in UIActivityViewController"
  s.homepage     = "https://github.com/AquaSupport/AQSActionMessageActivity"
  s.license      = "MIT"
  s.author       = { "kaiinui" => "lied.der.optik@gmail.com" }
  s.source       = { :git => "https://github.com/AquaSupport/AQSActionMessageActivity.git", :tag => "v0.1.0" }
  s.source_files  = "AQSActionMessageActivity/Classes/**/*.{h,m}"
  s.resources = ["AQSActionMessageActivity/Classes/**/*.png"]
  s.requires_arc = true
  s.platform = "ios", '7.0'

  s.frameworks = "MessageUI"
end
