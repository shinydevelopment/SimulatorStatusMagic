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

Note that SimulatorStatusMagic calls non-public APIs and should not be submitted to the app store. If you wish to add SimulatorStatusMagic for Debug configuration only, follow these steps:

* Ensure that SimulatorStatusMagiciOS.framework is within your project folder, but not added to any project target
* In app target Build Settings, expand the Framework Search Paths and add the framework's containing folder in the Debug configuration. For example, `$(SRCROOT)/ThirdPartyFrameworks/`
* Now you should be able to import and compile with SimulatorStatusMagiciOS, but app will crash with error:
`dyld: Library not loaded: @rpath/SimulatorStatusMagiciOS.framework/SimulatorStatusMagiciOS`
* To solve this, open app target's Build Phases and click the + icon then select New Run Script Phase
* Configure Run Script phase to embed SimulatorStatusMagiciOS.framework only when Debug configuration is used
 * Use the script `embed-debug-only-framework.sh` that is [available here](https://gist.github.com/kenthumphries/cf04683184217c7331f9c213c556c65a)

Now that SimilatorStatusMagic is added only for Debug configuration, you must ensure that any imports or calls to SDStatusBarManager are made between `#if DEBUG` and `#endif`.
