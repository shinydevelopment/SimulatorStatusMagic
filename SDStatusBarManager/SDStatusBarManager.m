// --------------------------------------------------------------------------------
// The MIT License (MIT)
//
// Copyright (c) 2014 Shiny Development
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// --------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "SDStatusBarManager.h"
#import "SDStatusBarOverriderPre8_3.h"
#import "SDStatusBarOverriderPost8_3.h"
#import "SDStatusBarOverriderPost9_0.h"

static NSString * const SDStatusBarManagerUsingOverridesKey = @"using_overrides";
static NSString * const SDStatusBarManagerBluetoothStateKey = @"bluetooth_state";
static NSString * const SDStatusBarManagerTimeStringKey  = @"time_string";
static NSString * const SDStatusBarManagerNetworkTypeKey = @"network_type";
static NSString * const SDStatusBarManagerCarrierNameKey = @"carrier_name";

@interface SDStatusBarManager ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) id <SDStatusBarOverrider> overrider;
@end

@implementation SDStatusBarManager

- (void)enableOverrides
{
  self.usingOverrides = YES;

  self.overrider.timeString  = [self localizedTimeString];
  self.overrider.carrierName = self.carrierName;
  self.overrider.bluetoothEnabled   = self.bluetoothState != SDStatusBarManagerBluetoothHidden;
  self.overrider.bluetoothConnected = self.bluetoothState == SDStatusBarManagerBluetoothVisibleConnected;
  self.overrider.dataNetworkType    = self.dataNetworkType;
  
  [self.overrider enableOverrides];
}

- (void)disableOverrides
{
  self.usingOverrides = NO;
  [self.overrider disableOverrides];
}

#pragma mark Properties
- (BOOL)usingOverrides
{
  return [self.userDefaults boolForKey:SDStatusBarManagerUsingOverridesKey];
}

- (void)setUsingOverrides:(BOOL)usingOverrides
{
  [self.userDefaults setBool:usingOverrides forKey:SDStatusBarManagerUsingOverridesKey];
}

- (void)setBluetoothState:(SDStatusBarManagerBluetoothState)bluetoothState
{
  if (self.bluetoothState == bluetoothState) return;

  [self.userDefaults setValue:@(bluetoothState) forKey:SDStatusBarManagerBluetoothStateKey];
  [self enableOverridesIfUsingOverrides];
}

- (SDStatusBarManagerBluetoothState)bluetoothState
{
  return [[self.userDefaults valueForKey:SDStatusBarManagerBluetoothStateKey] integerValue];
}

- (void)setTimeString:(NSString *)timeString
{
  if ([self.timeString isEqualToString:timeString]) return;
  
  _timeString = timeString;
  [self.userDefaults setObject:timeString forKey:SDStatusBarManagerTimeStringKey];
  [self enableOverridesIfUsingOverrides];
}

- (void)setDataNetworkType:(SDStatusBarManagerDataNetworkType)dataNetworkType
{
  if (self.dataNetworkType == dataNetworkType) return;
  
  _dataNetworkType = dataNetworkType;
  [self.userDefaults setValue:@(dataNetworkType) forKey:SDStatusBarManagerNetworkTypeKey];
  [self enableOverridesIfUsingOverrides];
}

- (void)setCarrierName:(NSString *)carrierName
{
  _carrierName = carrierName;
  [self.userDefaults setValue:carrierName forKey:SDStatusBarManagerCarrierNameKey];
  [self enableOverridesIfUsingOverrides];
}

- (void)enableOverridesIfUsingOverrides
{
  if (self.usingOverrides) {
    // Refresh the active status bar
    [self enableOverrides];
  }
}

- (NSUserDefaults *)userDefaults
{
  if (!_userDefaults) {
    _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.shinydevelopment.SDStatusBarManager"];
  }
  return _userDefaults;
}

- (id<SDStatusBarOverrider>)overrider
{
  if (!_overrider) {
    BOOL before9_0 = ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending);
    BOOL before8_3 = ([[[UIDevice currentDevice] systemVersion] compare:@"8.3" options:NSNumericSearch] == NSOrderedAscending);
    if (before8_3) {
      _overrider = [SDStatusBarOverriderPre8_3 new];
    } else if (before9_0) {
      _overrider = [SDStatusBarOverriderPost8_3 new];
    } else {
      _overrider = [SDStatusBarOverriderPost9_0 new];
    }
  }
  return _overrider;
}

#pragma mark Date helper
- (NSString *)localizedTimeString
{
  if (self.timeString.length > 0) {
    return self.timeString;
  }
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateStyle = NSDateFormatterNoStyle;
  formatter.timeStyle = NSDateFormatterShortStyle;

  NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
  components.hour = 9;
  components.minute = 41;

  return [formatter stringFromDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

- (void)loadDefaults
{
  self.carrierName     = [self.userDefaults valueForKey:SDStatusBarManagerCarrierNameKey];
  self.dataNetworkType = [self.userDefaults integerForKey:SDStatusBarManagerNetworkTypeKey];
  self.bluetoothState  = [self.userDefaults integerForKey:SDStatusBarManagerBluetoothStateKey];
  self.timeString      = [self.userDefaults valueForKey:SDStatusBarManagerTimeStringKey];
}

#pragma mark Singleton instance
+ (SDStatusBarManager *)sharedInstance
{
  static dispatch_once_t predicate = 0;
  __strong static SDStatusBarManager *sharedObject = nil;
  dispatch_once(&predicate, ^{ sharedObject = [[self alloc] init]; });
  [sharedObject loadDefaults];
  return sharedObject;
}

@end
