cd "$(dirname "$0")"

if [ -z "$1" ]; then
  DEVICE="booted"
else
  DEVICE="$1"
fi

xcodebuild -scheme "SimulatorStatusMagicDlib" -sdk iphonesimulator -derivedDataPath build
xcrun simctl spawn "$DEVICE" launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES="$PWD/build/Build/Products/Debug-iphonesimulator/libSimulatorStatusMagicDlib.dylib"
xcrun simctl spawn "$DEVICE" launchctl stop com.apple.SpringBoard
