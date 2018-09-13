//
//  SDStatusBarOverriderPost12_0.m
//  SimulatorStatusMagic
//
//  Created by Scott Talbot on 6/6/18.
//  Copyright © 2018 Shiny Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDStatusBarOverriderPost12_0.h"

typedef NS_ENUM(int, StatusBarItem) {
  // 0
  // 1
  // 2
  // 3
  SignalStrengthBars = 4,
  SecondarySignalStrengthBars = 5,
  // 6
  // 7
  // 8
  // 9
  // 10
  // 11
  // 12
  BatteryDetail = 13,
  // 14
  // 15
  Bluetooth = 16,
  // 17
  // 18
  // 19
  // 20
  // 21
  // 22
  // 23
  // 24
  // 25
  // 26
  // 27
  // 28
  // 29
  // 30
  // 31
  // 32
  // 33
  // 34
  // 35
  // 36
  // 37
  // 38
  // 39
  // 40
};

typedef NS_ENUM(unsigned int, BatteryState) {
  BatteryStateUnplugged = 0
};

typedef struct {
  bool itemIsEnabled[41];
  char timeString[64];
  char shortTimeString[64];
  char dateString[256];
  int gsmSignalStrengthRaw;
  int secondaryGsmSignalStrengthRaw;
  int gsmSignalStrengthBars;
  int secondaryGsmSignalStrengthBars;
  char serviceString[100];
  char secondaryServiceString[100];
  char serviceCrossfadeString[100];
  char secondaryServiceCrossfadeString[100];
  char serviceImages[2][100];
  char operatorDirectory[1024];
  unsigned int serviceContentType;
  unsigned int secondaryServiceContentType;
  int wifiSignalStrengthRaw;
  int wifiSignalStrengthBars;
  unsigned int dataNetworkType;
  unsigned int secondaryDataNetworkType;
  int batteryCapacity;
  unsigned int batteryState;
  char batteryDetailString[150];
  int bluetoothBatteryCapacity;
  int thermalColor;
  unsigned int thermalSunlightMode : 1;
  unsigned int slowActivity : 1;
  unsigned int syncActivity : 1;
  char activityDisplayId[256];
  unsigned int bluetoothConnected : 1;
  unsigned int displayRawGSMSignal : 1;
  unsigned int displayRawWifiSignal : 1;
  unsigned int locationIconType : 1;
  unsigned int quietModeInactive : 1;
  unsigned int tetheringConnectionCount;
  unsigned int batterySaverModeActive : 1;
  unsigned int deviceIsRTL : 1;
  unsigned int lock : 1;
  char breadcrumbTitle[256];
  char breadcrumbSecondaryTitle[256];
  char personName[100];
  unsigned int electronicTollCollectionAvailable : 1;
  unsigned int wifiLinkWarning : 1;
  unsigned int wifiSearching : 1;
  double backgroundActivityDisplayStartDate;
  unsigned int shouldShowEmergencyOnlyStatus : 1;
  unsigned int secondaryCellularConfigured : 1;
  char primaryServiceBadgeString[100];
  char secondaryServiceBadgeString[100];
} StatusBarRawData;

typedef struct {
  bool overrideItemIsEnabled[41];
  unsigned int overrideTimeString : 1;
  unsigned int overrideDateString : 1;
  unsigned int overrideGsmSignalStrengthRaw : 1;
  unsigned int overrideSecondaryGsmSignalStrengthRaw : 1;
  unsigned int overrideGsmSignalStrengthBars : 1;
  unsigned int overrideSecondaryGsmSignalStrengthBars : 1;
  unsigned int overrideServiceString : 1;
  unsigned int overrideSecondaryServiceString : 1;
  unsigned int overrideServiceImages : 2;
  unsigned int overrideOperatorDirectory : 1;
  unsigned int overrideServiceContentType : 1;
  unsigned int overrideSecondaryServiceContentType : 1;
  unsigned int overrideWifiSignalStrengthRaw : 1;
  unsigned int overrideWifiSignalStrengthBars : 1;
  unsigned int overrideDataNetworkType : 1;
  unsigned int overrideSecondaryDataNetworkType : 1;
  unsigned int disallowsCellularDataNetworkTypes : 1;
  unsigned int overrideBatteryCapacity : 1;
  unsigned int overrideBatteryState : 1;
  unsigned int overrideBatteryDetailString : 1;
  unsigned int overrideBluetoothBatteryCapacity : 1;
  unsigned int overrideThermalColor : 1;
  unsigned int overrideSlowActivity : 1;
  unsigned int overrideActivityDisplayId : 1;
  unsigned int overrideBluetoothConnected : 1;
  unsigned int overrideBreadcrumb : 1;
  unsigned int overrideLock;
  unsigned int overrideDisplayRawGSMSignal : 1;
  unsigned int overrideDisplayRawWifiSignal : 1;
  unsigned int overridePersonName : 1;
  unsigned int overrideWifiLinkWarning : 1;
  unsigned int overrideSecondaryCellularConfigured : 1;
  unsigned int overridePrimaryServiceBadgeString : 1;
  unsigned int overrideSecondaryServiceBadgeString : 1;
  StatusBarRawData values;
} StatusBarOverrideData;

@class UIStatusBarServer;

@protocol UIStatusBarServerClient

@required

- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveDoubleHeightStatusString:(NSString *)arg2 forStyle:(long long)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveGlowAnimationState:(bool)arg2 forStyle:(long long)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveStatusBarData:(const StatusBarRawData *)arg2 withActions:(int)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveStyleOverrides:(int)arg2;

@end

@interface UIStatusBarServer : NSObject

@property (nonatomic, strong) id<UIStatusBarServerClient> statusBar;

+ (void)postStatusBarOverrideData:(StatusBarOverrideData *)arg1;
+ (void)permanentizeStatusBarOverrideData;
+ (StatusBarOverrideData *)getStatusBarOverrideData;

@end

@implementation SDStatusBarOverriderPost12_0

@synthesize timeString;
@synthesize carrierName;
@synthesize bluetoothConnected;
@synthesize bluetoothEnabled;
@synthesize batteryDetailEnabled;
@synthesize networkType;

- (void)enableOverrides {
  StatusBarOverrideData *overrides = [UIStatusBarServer getStatusBarOverrideData];

  // Set 9:41 time in current localization
  strcpy(overrides->values.timeString, [self.timeString cStringUsingEncoding:NSUTF8StringEncoding]);
  overrides->overrideTimeString = 1;

  // Enable 5 bars of mobile (iPhone only)
  if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
    overrides->overrideItemIsEnabled[SignalStrengthBars] = 1;
    overrides->values.itemIsEnabled[SignalStrengthBars] = 1;
    overrides->overrideGsmSignalStrengthBars = 1;
    overrides->values.gsmSignalStrengthBars = 5;
  }

  overrides->overrideDataNetworkType = self.networkType != SDStatusBarManagerNetworkTypeWiFi;
  overrides->values.dataNetworkType = self.networkType - 1;

  // Remove carrier text for iPhone, set it to "iPad" for the iPad
  overrides->overrideServiceString = 1;
  NSString *carrierText = self.carrierName;
  if ([carrierText length] <= 0) {
    carrierText = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? @"" : @"iPad";
  }
  strcpy(overrides->values.serviceString, [carrierText cStringUsingEncoding:NSUTF8StringEncoding]);

  // Battery: 100% and unplugged
  overrides->overrideItemIsEnabled[BatteryDetail] = YES;
  overrides->values.itemIsEnabled[BatteryDetail] = YES;
  overrides->overrideBatteryCapacity = YES;
  overrides->values.batteryCapacity = 100;
  overrides->overrideBatteryState = YES;
  overrides->values.batteryState = BatteryStateUnplugged;
  overrides->overrideBatteryDetailString = YES;
  NSString *batteryDetailString = self.batteryDetailEnabled ? [NSString stringWithFormat:@"%@%%", @(overrides->values.batteryCapacity)] : @" ";
  // Setting this to an empty string will not work, it needs to be a @" "
  strcpy(overrides->values.batteryDetailString, [batteryDetailString cStringUsingEncoding:NSUTF8StringEncoding]);

  // Bluetooth
  overrides->overrideItemIsEnabled[Bluetooth] = !!self.bluetoothEnabled;
  overrides->values.itemIsEnabled[Bluetooth] = !!self.bluetoothEnabled;
  if (self.bluetoothEnabled) {
    overrides->overrideBluetoothConnected = self.bluetoothConnected;
    overrides->values.bluetoothConnected = self.bluetoothConnected;
  }

  // Actually update the status bar
  [UIStatusBarServer postStatusBarOverrideData:overrides];

  // Remove the @" " used to trick the battery percentage into not showing, if used
  if (!self.batteryDetailEnabled) {
    batteryDetailString = @"";
    strcpy(overrides->values.batteryDetailString, [batteryDetailString cStringUsingEncoding:NSUTF8StringEncoding]);
    [UIStatusBarServer postStatusBarOverrideData:overrides];
  }

  // Lock in the changes, reset simulator will remove this
  [UIStatusBarServer permanentizeStatusBarOverrideData];
}

- (void)disableOverrides {
  StatusBarOverrideData *overrides = [UIStatusBarServer getStatusBarOverrideData];

  // Remove all overrides that use the array of bools
  bzero(overrides->overrideItemIsEnabled, sizeof(overrides->overrideItemIsEnabled));
  bzero(overrides->values.itemIsEnabled, sizeof(overrides->values.itemIsEnabled));

  // Remove specific overrides (separate flags)
  overrides->overrideTimeString = 0;
  overrides->overrideGsmSignalStrengthBars = 0;
  overrides->overrideDataNetworkType = 0;
  overrides->overrideBatteryCapacity = 0;
  overrides->overrideBatteryState = 0;
  overrides->overrideBatteryDetailString = 0;
  overrides->overrideBluetoothConnected = 0;

  // Carrier text (it's an override to set it back to the default)
  overrides->overrideServiceString = 1;
  strcpy(overrides->values.serviceString, [NSLocalizedString(@"Carrier", @"Carrier") cStringUsingEncoding:NSUTF8StringEncoding]);

  // Actually update the status bar
  [UIStatusBarServer postStatusBarOverrideData:overrides];

  // Have to call this to remove all the overrides
  [UIStatusBarServer permanentizeStatusBarOverrideData];
}

@end
