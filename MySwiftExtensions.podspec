Pod::Spec.new do |s|  
  s.name             = "MySwiftExtensions" 
  s.version          = "1.0.0" 
  s.summary          = "Swift延展"  
  s.homepage         = "https://github.com/mayaosb2/MySwiftExtensions"   
  s.license          = 'MIT'  
  s.author           = { "剑啸青云梦一生" => "913831110@qq.com" }  
  s.source           = { :git => "https://github.com/mayaosb2/MySwiftExtensions.git", :tag => s.version.to_s }   
  s.requires_arc = true  
  s.ios.deployment_target = '8.0'
  s.source_files = 'MySwiftExtension/*.*'
  s.dependencies = {
   'SDWebImage' => ['3.8.2'],
   'MJRefresh' => ['3.1.0'],
   'CryptoSwift' => ['0.2.2'],
   'SnapKit' => ['0.19.1']
   }

end 