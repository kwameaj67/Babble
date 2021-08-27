# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'VR_App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'GoogleSignIn'
  pod 'MBProgressHUD'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'googleapis', :path => '.'
  # Pods for VR_App
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
   end
  end
  

end
