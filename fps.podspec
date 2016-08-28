Pod::Spec.new do |s|
s.name = 'FPS'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'An FPS moniter view on iOS.'
s.homepage = 'https://github.com/dimsky/FPSDemo'
s.authors = { 'dimsky' => 'dimsky@163.com' }
s.source = { :git => 'https://github.com/dimsky/FPSDemo.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'FPS/*.{swift}'
end