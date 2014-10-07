## Simulator Status Magic

Modify the iOS Simulator so that it has a perfect status bar, then run your app and take perfect screenshots every time. The modifications made are designed to match the images you see on the Apple site and are as follows:

* 9:41 AM is displayed for the time.
* The battery is full and shows 100% next to it.
* On iPhone: The carrier text is removed, 5 bars of cellular signal and full WiFi bars are displayed.
* On iPad: The carrier text is set to "iPad" and full WiFi bars are displayed.

### How do I use it?

* Clone this repository.
* Open SimulatorStatusMagic.xcodeproj with Xcode 6 (or above).
* Run the app on whichever simulator type you would like to modify, it works with every device.
* Once the app launches, press the only button on the screen :)
* That's it, you're done! Now just run your app and take screenshots.

### How do I remove the customisations?

Run the app again and click "Restore Default Status Bar". Resetting the iOS simulator using the menu option in the app also works.

### Does this work on device?

No. The status bar server is blocked on devices. However, [this post contains more information on taking perfect screenshots on real devices](http://shinydevelopment.com/blog/status-magic-and-iphone6-screen-sizes/).

## How does this work?

Until we have a little time to document this better, [the source code contains everything you need to know](https://github.com/shinydevelopment/SimulatorStatusMagic/blob/master/SimulatorStatusMagic/SDStatusBarManager.m) :)

## Contributing

Sure, however the scope of this project is quite limited. Pull requests will be accepted for bugs or to match any changes Apple make to the default status bar in marketing images on apple.com. Pull requests adding features like being able to set custom carrier text, times other than 9:41 AM or anything which does not match the marketing images on apple.com will be rejected.
