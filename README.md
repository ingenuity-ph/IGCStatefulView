# IGCStatefulView

[![CI Status](http://img.shields.io/travis/ingenuity-ph/IGCStatefulView.svg?style=flat)](https://travis-ci.org/ingenuity-ph/IGCStatefulView)
[![Version](https://img.shields.io/cocoapods/v/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)
[![License](https://img.shields.io/cocoapods/l/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)
[![Platform](https://img.shields.io/cocoapods/p/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)

## Example

![IGCStatefulView](https://github.com/ingenuity-ph/IGCStatefulView/blob/master/Screens/stateview.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

IGCStatefulView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IGCStatefulView'
```

## Overview

A big thanks to [Sauvik Dolui](https://github.com/sauvikdolui) and his library, [SDStateTableView](https://github.com/sauvikdolui/SDStateTableView) for giving me the inspiration to create my own take on stateful views.

## Usage

It serves as an extension to `UIView` instances, wherein it adds a `configureViewDataState` method. It accepts a pre-defined `IGCStatefulView` enum value. Sample usage is as follows:

```swift
// UIView
self.infoView.configureViewDataState(as: .loading(message: nil, styles: nil))

// UITableView
self.tableView.configureViewDataState(as: .loading(message: "Loading...", styles: nil))

// UICollectionView
self.collectionView.configureViewDataState(as: .success)
```

Custom styling is available but fairly limited to a few options for each of `IGCStateView` instance's properties. Styling is made easy by using the `IGCStateViewStyles` struct, wherein all styling options has been defined along with its initial values. Sample usage is as follows:

##### Code

![IGCStatefulView](https://github.com/ingenuity-ph/IGCStatefulView/blob/master/Screens/alloptions.png)

##### Output

![IGCStatefulView](https://github.com/ingenuity-ph/IGCStatefulView/blob/master/Screens/alloptions.gif)


## TODO

1. Fix to iPhone X issue.

## Contributing

1. Fork repository.
2. Create your feature branch: `git checkout -b feature/<feature-name>`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin feature/<feature-name>`.
5. Submit a pull request.

## Author

Jason Jon E. Carreos (jason@ingenuity.ph)

## License

IGCStatefulView is available under the MIT license. See the LICENSE file for more info.
