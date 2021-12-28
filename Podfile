# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'My MMR' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for My MMR
# the below code for setting target to satisfy the Xcode target iOS version
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end

  pod 'DropDown', '2.3.13'
  pod 'LeagueAPI'
  pod 'AlamofireObjectMapper', :git => 'https://github.com/RomanPodymov/AlamofireObjectMapper.git', :branch => 'xcode-10-2-fix'
  pod 'Resolver'
end

