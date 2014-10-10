#
# Be sure to run `pod lib lint SimulatorStatusMagic.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SimulatorStatusMagic"
  s.version          = "0.1.0"
  s.summary          = "Enable perfect status bar simulation in the iOS Simulator."
  s.description      = <<-DESC
                        Modify the iOS Simulator so that it has a perfect status bar, then run your app and take perfect screenshots every time. The modifications made are designed to match the images you see on the Apple site and are as follows:

                        * 9:41 AM is displayed for the time.
                        * The battery is full and shows 100%.
                        * On iPhone: The carrier text is removed, 5 bars of cellular signal and full WiFi bars are displayed.
                        * On iPad: The carrier text is set to "iPad" and full WiFi bars are displayed.
                       DESC
  s.homepage         = "https://github.com/shinydevelopment/SimulatorStatusMagic"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Dave Verwer" => "dave.verwer@shinydevelopment.com" }
  s.source           = { :git => "https://github.com/shinydevelopment/SimulatorStatusMagic.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SimulatorStatusMagic' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
