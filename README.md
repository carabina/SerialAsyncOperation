## SerialAsyncOperation

[![Build Status](https://travis-ci.org/icetime17/SerialAsyncOperation.svg?branch=master)](https://travis-ci.org/icetime17/SerialAsyncOperation)
[![Cocoapods](https://img.shields.io/cocoapods/v/SerialAsyncOperation.svg)](https://cocoapods.org/pods/SerialAsyncOperation)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/icetime17/SerialAsyncOperation)
[![Xcode](https://img.shields.io/badge/Xcode-8.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

Use NSOperation to implement ***serial asynchronous*** task.


## Requirements:
Xcode 8 (or later) with Objective-C. This library is made for iOS 8 or later.


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SerialAsyncOperation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target '<Your Target Name>' do
    pod 'SerialAsyncOperation'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SerialAsyncOperation into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "icetime17/SerialAsyncOperation"
```

Run `carthage update` to build the framework and drag the built `SerialAsyncOperation.framework` in folder /Carthage/Build/iOS into your Xcode project.

### Manually

Add the ***Sources*** folder to your Xcode project to use all extensions, or a specific extension.


## Usage

Please check the demo.

## Contact

If you find an issue, just open a ticket. Pull requests are warmly welcome as well.


## License

SerialAsyncOperation is released under the MIT license. See LICENSE.md for details.
