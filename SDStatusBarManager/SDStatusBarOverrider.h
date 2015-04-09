//
//  SDStatusBarOverrider.h
//  SimulatorStatusMagic
//
//  Created by Craig Siemens on 2015-04-09.
//  Copyright (c) 2015 Shiny Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDStatusBarOverrider <NSObject>

@property (copy, nonatomic) NSString *timeString;

@property (assign, nonatomic) BOOL bluetoothEnabled;
@property (assign, nonatomic) BOOL bluetoothConnected;

- (void)enableOverrides;
- (void)disableOverrides;

@end
