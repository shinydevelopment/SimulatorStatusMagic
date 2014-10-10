## Simulator Status Magic

Modify the iOS Simulator so that it has a perfect status bar, then run your app and take perfect screenshots every time. The modifications made are designed to match the images you see on the Apple site and are as follows:

* 9:41 AM is displayed for the time.
* The battery is full and shows 100%.
* On iPhone: The carrier text is removed, 5 bars of cellular signal and full WiFi bars are displayed.
* On iPad: The carrier text is set to "iPad" and full WiFi bars are displayed.

### How do I use it?

* Clone this repository.
* Open SimulatorStatusMagic.xcodeproj with Xcode 6 (or above).
* Run the app on whichever simulator type you would like to modify, it works with every device.
* Once the app launches, press the only button on the screen :)
* That's it, you're done! Now just run your app and take screenshots.

#### In unit tests for automated screenshots 

SimulatorStatusMagic is also available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod "SimulatorStatusMagic"
```
If you want to use git submodules: add this repository as a submodule and add both SDStatusBarManager files from ```Pods/Classes``` to your projects.

Then in your unit test call
```objectivec
[[SDStatusBarManager sharedInstance] enableOverrides];
```
before your screenshot code to enable the status bar overrides and
```objectivec
[[SDStatusBarManager sharedInstance] disableOverrides];
```
after your screenshots code to disable the status bar overrides.

### How do I remove the customisations?

Run the app again and click "Restore Default Status Bar". Resetting the iOS Simulator using the normal menu option also works.

### Does this work on device?

No. The status bar server is blocked on devices. However, [this post contains more information on taking perfect screenshots on real devices](http://shinydevelopment.com/blog/status-magic-and-iphone6-screen-sizes/).

### How does this work?

Until we have a little time to document this better, [the source code contains everything you need to know](https://github.com/shinydevelopment/SimulatorStatusMagic/blob/master/SimulatorStatusMagic/SDStatusBarManager.m) :)

## Contributing

We'd love contributions and even have some suggestions for things that might need working on:

* Found a bug? If you report it with a pull request attached then you get a gold star :)
* Non-English language support. We'd love it to work with more languages.

However, the scope of this project is intentionally limited. We're not planning to add options to this to allow ultimate customisation of the status bar. It's intended to do just one job really well, change the status bar to match [Apple's marketing materials](http://www.apple.com/ios/). Things like custom time text or custom carrier text are probably out of scope.
