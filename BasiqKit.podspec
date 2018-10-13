Pod::Spec.new do |s|
  s.name         = "BasiqKit"
  s.version      = "0.0.1"
  s.summary      = "BasiqKit for basiq.io"
  s.description  = "BasiqKit allows to use Basiq API and choose banks, fetch transaction with native way on iOS"

  s.dependency 'PromisesSwift', "= 1.2.3"
  s.ios.deployment_target  = '10.0'
  s.homepage     = "https://github.com/tapkain/BasiqKit"
  s.license      = "MIT"
  s.swift_version = "4.2"
  s.author             = { "Eugene Velizhenkov" => "tredasaibot@gmail.com" }
  s.source       = { :git => "https://github.com/tapkain/BasiqKit.git", :commit => "83859adb9b38a3c5bf05933b0d3a99dd5f0834bd" }
  s.source_files  = "BasiqKit/**/*.{swift}"
  s.exclude_files = "Classes/Exclude"

end
