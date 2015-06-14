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

#import "ViewController.h"
#import "SDStatusBarManager.h"

@interface ViewController () 
@property (strong, nonatomic) IBOutlet UIButton *overrideButton;
@property (strong, nonatomic) IBOutlet UITextField *timeStringTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *bluetoothSegmentedControl;
@end

@implementation ViewController

#pragma mark View lifecycle
- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setOverrideButtonText];
  [self setBluetoothSegementedControlSelectedSegment];
  [self setTimeStringTextFieldText];
}

#pragma mark Actions
- (IBAction)overrideButtonTapped:(UIButton *)sender
{
  if ([SDStatusBarManager sharedInstance].usingOverrides) {
    [[SDStatusBarManager sharedInstance] disableOverrides];
    [self setOverrideButtonText];
  } else {
    [[SDStatusBarManager sharedInstance] enableOverrides];
    [self setOverrideButtonText];
  }
}

- (IBAction)timeStringTextFieldEditingChanged:(UITextField *)textField
{
  [SDStatusBarManager sharedInstance].timeString = textField.text;
}

- (IBAction)bluetoothStatusChanged:(UISegmentedControl *)sender
{
  // Note: The order of the segments should match the definition of SDStatusBarManagerBluetoothState
  [[SDStatusBarManager sharedInstance] setBluetoothState:sender.selectedSegmentIndex];
}

#pragma mark Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

#pragma mark UI helpers
- (void)setOverrideButtonText
{
  if ([SDStatusBarManager sharedInstance].usingOverrides) {
    [self.overrideButton setTitle:NSLocalizedString(@"Restore Default Status Bar", @"Restore Default Status Bar")  forState:UIControlStateNormal];
  } else {
    [self.overrideButton setTitle:NSLocalizedString(@"Apply Clean Status Bar Overrides", "Apply Clean Status Bar Overrides") forState:UIControlStateNormal];
  }
}

- (void)setBluetoothSegementedControlSelectedSegment
{
  // Note: The order of the segments should match the definition of SDStatusBarManagerBluetoothState
  self.bluetoothSegmentedControl.selectedSegmentIndex = [SDStatusBarManager sharedInstance].bluetoothState;
}

- (void)setTimeStringTextFieldText
{
  self.timeStringTextField.text = [SDStatusBarManager sharedInstance].timeString;
}

#pragma mark Status bar settings
- (BOOL)prefersStatusBarHidden
{
  return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleDefault;
}

@end
