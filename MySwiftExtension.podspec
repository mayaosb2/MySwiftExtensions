Pod::Spec.new do |s|  
  s.name             = "MySwiftExtension" 
  s.version          = "1.0.0" 
  s.summary          = "Swift延展"  
  s.homepage         = "https://github.com/mayaosb2/MySwiftExtension"   
  s.license          = 'MIT'  
  s.author           = { "马耀" => "913831110@qq.com" }  
  s.source           = { :git => "https://github.com/mayaosb2/MySwiftExtension.git", :tag => s.version.to_s }   

  s.requires_arc = true  
  s.ios.deployment_target = '8.0'
  s.source_files = 'MySwiftExtension/*' 

end 