Pod::Spec.new do |spec|
  spec.name             = 'CHFoundation'
  spec.version          = '0.4.1'
  spec.license          = 'MIT'
  spec.homepage         = 'https://github.com/royhsu/chocolate-foundation'
  spec.authors          = { 'Tiny World' => 'roy.hsu@tinyworld.cc' }
  spec.summary          = 'A personalized foundation framework for Swift.'
  spec.source           = { :git => 'https://github.com/royhsu/chocolate-foundation.git', :tag => spec.version }
  spec.source_files     = 'Source/*.swift'

  spec.ios.deployment_target = '8.0'

  spec.dependency 'PromiseKit', '4.0.1'

end
