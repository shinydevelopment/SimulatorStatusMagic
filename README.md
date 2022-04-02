## Simulator Status Magic

Modify the iOS Simulator so that it has a perfect status bar, then run your app and take perfect screenshots every time. The modifications made are designed to match the images you see on the Apple site and are as follows:

* 9:41 AM is displayed for the time.
* The battery is full and shows 100%.
* 5 bars of cellular signal and full WiFi bars are displayed.
* Tue Jan 9 is displayed for the date (iPad only)

## Can't I just use `xcrun simctl status_bar`? 🚀

Starting in Xcode 11, the `simctl` command line tool includes a `status_bar` option that allows you to override the appearance of the status bar in the simulator. Hopefully this will eventually supercede the need for SimulatorStatusMagic, but at the moment it still has holes that make this project continue to be relevant. In particular, `simctl status_bar` does not currently provide a way to add localized date and time strings in the status bar.

### How do I use it?

* Clone this repository.
* Open SimulatorStatusMagic.xcodeproj with Xcode 6 (or above).
* Run the app target `SimulatorStatusMagic` (not `SimulatorStatusMagiciOS`) on whichever simulator type you would like to modify (it works with every device).
* Once the app launches, press the only button on the screen :)
* That's it, you're done! Now just run your app and take screenshots.

### How do I remove the customisations?

Run the app again and click "Restore Default Status Bar". Resetting the iOS Simulator using the normal menu option also works.

### I have a script to take my screenshots, can I automate this?

Yes! SimulatorStatusMagic is available via [CocoaPods](http://cocoapods.org), [Carthage](https://github.com/Carthage/Carthage), Swift Package Manager and as a standalone source release. [Installation instructions](https://github.com/shinydevelopment/SimulatorStatusMagic/blob/master/INSTALLATION.md) are available.

**Cocoapods/Carthage**
It is recommended to **only** include `SDStatusBarManager` in your debug configuration so that the code is **never** included in release builds. When you want to apply a perfect status bar, call `[[SDStatusBarManager sharedInstance] enableOverrides]`. To restore the standard status bar, call `[[SDStatusBarManager sharedInstance] disableOverrides]`.

**Swift Package Manager**
SPM does not yet support conditionally linking packages based on build configuration. The recommended approach when using SPM is to link to your UI test target only, and enable the overrides from that target instead.

### What about automation of the sample app?

If you'd prefer to automate the app itself to automatically enable or disable the overrides, this can be done with environment variables.

Run with:

````
SIMULATOR_STATUS_MAGIC_OVERRIDES = enable
````

or

````
SIMULATOR_STATUS_MAGIC_OVERRIDES = disable
````

The overrides will be automatically enabled or disabled on launch.

### Does this work on device?

No. The status bar server is blocked on devices. However, macOS includes the facility to include a perfect status bar when recording your device screen with QuickTime ([Read more](https://appadvice.com/appnn/2014/08/quicktime-in-os-x-yosemite-reveals-that-apple-cares-about-status-bars)).

### How does this work?

The best idea is to check [the source code](https://github.com/shinydevelopment/SimulatorStatusMagic/blob/master/SDStatusBarManager/SDStatusBarManager.m) which should get you started with how it works :)

## Updating for new versions of iOS

There's a general pattern for updating this project to support a new version of iOS, although this could change if Apple changes something in the future.

### Prepare the new files.

1. Copy the previous release's `SDStatusBarOverriderPostXX_Y.{h,m}` files, and update them to the new version.
2. Update SDStatusBarManager.m to refer to the new overrider if detecting the new operating system version.

### Find the updated structs in the runtime headers. 

 1. Download the latest version of the [dsdump](https://github.com/DerekSelander/dsdump) tool.
 2. Run dsdump against the UIKitCore framework binary, to generate the private runtime headers.
 ```
 ./dsdump --objc -a x86_64 --verbose=5 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore --defined > ~/Desktop/UIKitCore.txt
 ```
3. Find `UIStatusBarServerListener` in the output. 

### Update the structs in the new overrider.

There are two structs, StatusBarRawData and StatusBarOverrideData, that need to be updated. Each corresponds to a line in the runtime header output for UIStatusBarServerListener. It should be pretty easy to figure out the mapping if you study it for a minute.

1. Update StatusBarRawData and StatusBarOverrideData to match any changes to the structs in the runtime headers.

### Check if it works

That should be it!

1. Run the sample app, and verify that the status bar is updated correctly.
2. If anything new has been added to the status bar that needs to be adjusted, make additional changes to your new SDStatusBarOverrider.

## Contributing

We'd love contributions! Found a bug? If you report it with a pull request attached then you get a gold star :)

However, the scope of this project is intentionally limited. We're not planning to add options to this to allow ultimate customisation of the status bar. It's intended to do just one job really well, change the status bar to match [Apple's marketing materials](http://www.apple.com/ios/).
