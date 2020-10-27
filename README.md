# ASMultiColorCircularLoader
This is a simple multicolor circular progress loader.

## Requirements
Xcode 11 and Swift 4+

## Installation
ASMultiColorCircularLoader is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ASMultiColorCircularLoader'
```
![alt-text](https://github.com/arijits95/ASMultiColorCircularLoader/blob/master/Resources/MultiColorCircularLoader.gif)

A simple and easy to use multicolor circular loader view which allows all the necessary customizations.

## Usage
Drag a view onto the storyboard and set it class to ASMultiColorCircularLoader.You can customize the appearance of the loader as shown below.

![alt-text](https://github.com/arijits95/ASMultiColorCircularLoader/blob/master/Resources/1ColorSpinner.gif)

```swift
let circularSpinner = CGRect(x: 0, y: 0, width: 150, height: 150)
circularSpinner.lineWidth = 5.0
circularSpinner.rotationAnimationDuration = 2.0
circularSpinner.lineDrawWithdrawValue = 0.95
circularSpinner.delayBetweenDrawAndWithdrawAnimation = 0
circularSpinner.colors = [.red]
circularSpinner.drawDurations = [0.5]
circularSpinner.drawDelays = [0.0]
circularSpinner.withdrawDurations = [0.5]
circularSpinner.withdrawDelays = [0.0]

circularSpinner.startAnimation()
```

![alt-text](https://github.com/arijits95/ASMultiColorCircularLoader/blob/master/Resources/2ColorSpinner.gif)

```swift
let circularSpinner = CGRect(x: 0, y: 0, width: 150, height: 150)
circularSpinner.lineWidth = 5.0
circularSpinner.rotationAnimationDuration = 2.0
circularSpinner.lineDrawWithdrawValue = 0.95
circularSpinner.delayBetweenDrawAndWithdrawAnimation = 0
circularSpinner.colors = [.red, .green]
circularSpinner.drawDurations = [0.5, 0.5]
circularSpinner.drawDelays = [0.0, 0.3]
circularSpinner.withdrawDurations = [0.5, 0.5]
circularSpinner.withdrawDelays = [0.3, 0.0]

circularSpinner.startAnimation()
```

![alt-text](https://github.com/arijits95/ASMultiColorCircularLoader/blob/master/Resources/3ColorSpinner.gif)

```swift
let circularSpinner = CGRect(x: 0, y: 0, width: 150, height: 150)
circularSpinner.lineWidth = 5.0
circularSpinner.rotationAnimationDuration = 10.0
circularSpinner.lineDrawWithdrawValue = 0.98
circularSpinner.delayBetweenDrawAndWithdrawAnimation = 0
circularSpinner.colors = [UIColor(rOS: 0.965, g: 0.659, b: 0.788), UIColor(rOS: 0.212, g: 0.675, b: 0.878), UIColor(rOS: 0.043, g: 0.714, b: 0.702)]
circularSpinner.drawDurations = [1.0, 0.6, 0.4]
circularSpinner.drawDelays = [0.0, 0.5, 0.8]
circularSpinner.withdrawDurations = [0.8, 0.6, 0.4]
circularSpinner.withdrawDelays = [0.3, 0.1, 0.0]

circularSpinner.startAnimation()
```

## Author
arijits95, arijits95@gmail.com

## License
ASMultiColorCircularLoader is available under the MIT license. See the LICENSE file for more info.
