xcodebuild -sdk iphonesimulator17.0 -scheme "SimulatorStatusMagicDlib" -derivedDataPath build
xcrun simctl spawn booted launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES="$PWD/build/Build/Products/Debug-iphonesimulator/libSimulatorStatusMagicDlib.dylib"
xcrun simctl spawn booted launchctl stop com.apple.SpringBoard
