DBSphereTagCloud
================

A 3D spherical tag cloud view of iOS.

## Introduction

DBSphereTagCloud is a 3D spherical tag cloud view using UIKit and Accelerate (provided by [SwiftNum](https://github.com/donald-pinckney/SwiftNum)).

You can customize the code easily because the code is simple.

![DBSphereTagCloud](https://raw.githubusercontent.com/apparition47/DBSphereTagCloud/master/SCREENSHOT.gif)

## Features

* 3D effect 3D效果
* auto rotation 自动旋转效果
* inertial effect after rotation 惯性滚动效果

## Installation

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```shell
$ gem install cocoapods
```

To integrate this into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DBSphereTagCloud', :git => "https://github.com/apparition47/DBSphereTagCloud.git", :branch => "swift", :submodules => true
end

```

## Usage
```Swift
  import DBSphereTagCloud

  let view: DBSphereView = DBSphereView(frame: CGRectMake(0, 100, 320, 320))
  view.setCloudTags(buttonArray)
  self.view.addSubView(view);
```

## License

Under MIT License.
