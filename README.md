# IGCStatefulView

[![CI Status](http://img.shields.io/travis/jason-ingenuity/IGCStatefulView.svg?style=flat)](https://travis-ci.org/jason-ingenuity/IGCStatefulView)
[![Version](https://img.shields.io/cocoapods/v/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)
[![License](https://img.shields.io/cocoapods/l/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)
[![Platform](https://img.shields.io/cocoapods/p/IGCStatefulView.svg?style=flat)](http://cocoapods.org/pods/IGCStatefulView)

## Example

![IGCStatefulView](https://github.com/jason-ingenuity/IGCStatefulView/blob/master/Screens/stateview.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

IGCStatefulView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IGCStatefulView'
```

## Usage

This package is heavily inspired by [SDStateTableView](https://github.com/sauvikdolui/SDStateTableView).

It serves as an extension to UIView instances wherein it adds a `setViewDataState` method. It accepts a pre-defined enum `IGCStatefulView`. Sample usage is as follows:

```swift
// UIView
self.infoView.setViewDataState(.loading(message: nil, styleParams: nil))

// UITableView
self.tableView.setViewDataState(.loading(message: "Loading...", styleParams: nil))

// UICollectionView
self.collectionView.setViewDataState(.success)
```

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

