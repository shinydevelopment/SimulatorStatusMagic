## Simulator Status Magic

Modify the iOS Simulator so that it has a perfect status bar, then run your app and take perfect screenshots every time. The modifications made are designed to match the images you see on the Apple site and are as follows:

* 9:41 AM is displayed for the time.
* The battery is full and shows 100%.
* On iPhone: The carrier text is removed, 5 bars of cellular signal and full WiFi bars are displayed.
* On iPad: The carrier text is set to "iPad" and full WiFi bars are displayed.

### How do I use it?

* Clone this repository.
* Open SimulatorStatusMagic.xcodeproj with Xcode 6 (or above).
* Run the app target `SimulatorStatusMagic` on whichever simulator type you would like to modify, it works with every device.
* Once the app launches, press the only button on the screen :)
* That's it, you're done! Now just run your app and take screenshots.

### How do I remove the customisations?

Run the app again and click "Restore Default Status Bar". Resetting the iOS Simulator using the normal menu option also works.

### I have a script to take my screenshots, can I automate this?

#### Install through Cocoapods

SimulatorStatusMagic is available through [CocoaPods](http://cocoapods.org). To install, simply add the following line to your Podfile:

```ruby
pod 'SimulatorStatusMagic', :configurations => ['Debug']
```

#### Install through Carthage

SimlatorStatusMagic is also available through [Carthage](https://github.com/Carthage/Carthage). Carthage is a simple decentralized package manager that is designed to be as simple as possible. Carthage will not make any modifications to your project, so installation is moderately more involved than with CocoaPods. To get started, ensure that you have installed Carthage and then create a Cartfile with the following content:

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

#### Install through source code

SimulatorStatusMagic can also be included as a dynamic framework by following steps: 

* Download the source code and open the XCode project
* Run the target `SimulatorStatusMagicUniversalFramework` which generates a universal framework for both device and simulator. 
* Drag and drop the generated framework into your project. 
* Import the framework using `@import SimulatorStatusMagiciOS;` in any file you may want to use it in.

#### Tips

We recommend only including `SDStatusBarManager` in your debug configuration so that this code is never included in release builds.

When you want to apply a perfect status bar, call `[[SDStatusBarManager sharedInstance] enableOverrides]`. To restore the standard status bar, call `[[SDStatusBarManager sharedInstance] disableOverrides]`.

### Does this work on device?

No. The status bar server is blocked on devices. However, [this post contains more information on taking perfect screenshots on real devices](http://shinydevelopment.com/blog/status-magic-and-iphone6-screen-sizes/).

### How does this work?

Until we have a little time to document this better, [the source code contains everything you need to know](https://github.com/shinydevelopment/SimulatorStatusMagic/blob/master/SDStatusBarManager/SDStatusBarManager.m) :)

## Contributing

We'd love contributions and even have some suggestions for things that might need working on:

* Found a bug? If you report it with a pull request attached then you get a gold star :)
* ~~Non-English language support. We'd love it to work with more languages.~~ Now works with every language!

However, the scope of this project is intentionally limited. We're not planning to add options to this to allow ultimate customisation of the status bar. It's intended to do just one job really well, change the status bar to match [Apple's marketing materials](http://www.apple.com/ios/). Things like custom time text or custom carrier text are probably out of scope.
