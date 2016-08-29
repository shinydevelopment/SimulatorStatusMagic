#### Installing with Cocoapods

SimulatorStatusMagic is available through [CocoaPods](http://cocoapods.org). To install, simply add the following line to your Podfile:

```ruby
pod 'SimulatorStatusMagic', :configurations => ['Debug']
```

#### Installing with Carthage

SimlatorStatusMagic is also available through [Carthage](https://github.com/Carthage/Carthage). Carthage will not make any modifications to your project, so installation is more involved than with CocoaPods. To get started, ensure that you have installed Carthage and then create a Cartfile with the following content:

```ruby
github "shinydevelopment/SimulatorStatusMagic"
```

Next bootstrap your environment by executing carthage update:

```sh
$ carthage update
```

Next drag SimulatorStatusMagiciOS.framework from Carthage/Build/iOS and onto your project and link it with your application target. Then select your application target within Xcode, navigate to the Build Phases panel and click the + icon and select New Run Script Phase. Set the content to:

```sh
/usr/local/bin/carthage copy-frameworks
```

In the Input Files section add:

- `$(SRCROOT)/Carthage/Build/iOS/SimulatorStatusMagiciOS.framework`

Now build your application target and everything should be set.

#### Installing without a dependency manager

SimulatorStatusMagic can also be included as a dynamic framework by following steps:

* Download the source code and open the XCode project
* Run the target `SimulatorStatusMagicUniversalFramework` which generates a universal framework for both device and simulator.
* Drag and drop the generated framework into your project.
