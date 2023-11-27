cd "$(dirname "$0")"
xcodebuild -scheme "SimulatorStatusMagicDlib" -sdk iphonesimulator -derivedDataPath build

# Set testing to detect XCTest simulators
xcrun simctl --set testing spawn $1 launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES="$PWD/build/Build/Products/Debug-iphonesimulator/libSimulatorStatusMagicDlib.dylib"
xcrun simctl --set testing spawn $1 launchctl stop com.apple.SpringBoard
