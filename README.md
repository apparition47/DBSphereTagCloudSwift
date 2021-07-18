DBSphereTagCloudSwift
================
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg) [![CocoaPods](https://img.shields.io/cocoapods/v/DBSphereTagCloudSwift.svg)](https://cocoapods.org/pods/DBSphereTagCloudSwift)

A 3D spherical tag cloud view for iOS using UIKit and Accelerate (provided by [SwiftNum](https://github.com/donald-pinckney/SwiftNum)). Ported from the original [Objective-C version written by @dongxinb](https://github.com/dongxinb/DBSphereTagCloud).

![DBSphereTagCloud](https://user-images.githubusercontent.com/3298414/31832079-9be84c94-b600-11e7-95d7-ccd980253199.gif)

## Features

* 3D effect 3D效果
* auto rotation 自动旋转效果
* inertial effect after rotation 惯性滚动效果

## Requirements

* iOS 8+
* Swift 5
* Xcode 12

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```shell
$ gem install cocoapods
```

To integrate this into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DBSphereTagCloudSwift'
end

```

### Carthage

[Carthage](https://github.com/Carthage/Carthage/) compatible.
Add the following into your `Cartfile`, then run `carthage update`.

```
github "apparition47/DBSphereTagCloudSwift"
```

### Swift Package Manager

Add `https://github.com/apparition47/DBSphereTagCloudSwift.git` to your project. Recommended adding with `Version` with `up to next major`.


## Usage
```Swift
  import DBSphereTagCloudSwift

  let view: DBSphereView = DBSphereView(frame: CGRectMake(0, 100, 320, 320))
  view.setCloudTags(buttonArray)
  self.view.addSubView(view);
```

## License

MIT License.
