//
//  IGCStatefulView.swift
//  IGCStatefulView
//
//  Created by Jason Jon E. Carreos on 23/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import Foundation
import UIKit

/// An enum for determining the current state of a `UIView` instance.
///
/// - success: No state view will be displayed since `UIView` content is available.
/// - loading: A loading state view will be displayed to indicate fetching and populating of data.
/// - error: An error state view will be displayed to indicate error on fetching data.
/// - none: Same behavior as `success`. May be used as default.
public enum IGCViewState {
    /// No state view will be displayed since `UIView` content is available.
    case success
    /// A loading state view will be displayed to indicate fetching and populating of data.
    /// - message: Text to be displayed.
    /// - styles: IGCStateViewStyles instance to provide additional styling to the view.
    case loading(message: String?, styles: IGCStateViewStyles?)
    /// An error state view will be displayed to indicate error on fetching data.
    /// - image: Image to be displayed.
    /// - title: Primary text to be displayed.
    /// - message: Supporting text to be displayed.
    /// - styles: IGCStateViewStyles instance to provide additional styling to the view.
    /// - buttonAction: Closure to be executed when button is pressed.
    ///                 Not supplying this parameter will not display the button.
    case error(
        image: UIImage?,
        title: String?,
        message: String,
        styles: IGCStateViewStyles?,
        buttonAction: ((UIButton) -> Void)?)
    /// Same behavior as `success`. May be used as default.
    case none
}

/// Custom type for setting various styles to `IGCStateView` properties.
public struct IGCStateViewStyles {
    public typealias ImageOptions = (image: UIImage, contentMode: UIViewContentMode)
    
    public var titleFont: UIFont
    public var titleColor: UIColor
    public var messageFont: UIFont
    public var messageColor: UIColor
    public var imageSize: CGFloat
    public var indicatorTintColor: UIColor
    public var buttonFont: UIFont
    public var buttonColor: UIColor
    public var backgroundColor: UIColor
    public var backgroundImageOptions: ImageOptions?
    
    public init(titleFont: UIFont? = UIFont.systemFont(ofSize: 18),
                titleColor: UIColor? = UIColor.black,
                messageFont: UIFont? = UIFont.systemFont(ofSize: 16),
                messageColor: UIColor? = UIColor.gray,
                imageSize: CGFloat? = 50,
                indicatorTintColor: UIColor? = UIColor.black,
                buttonFont: UIFont? = UIFont.systemFont(ofSize: 14),
                buttonColor: UIColor? = UIColor.black,
                backgroundColor: UIColor? = UIColor.white,
                backgroundImageOptions: ImageOptions? = nil) {
        self.titleFont = titleFont!
        self.titleColor = titleColor!
        
        self.messageFont = messageFont!
        self.messageColor = messageColor!
        
        self.imageSize = imageSize!
        
        self.indicatorTintColor = indicatorTintColor!
        
        self.buttonFont = buttonFont!
        self.buttonColor = buttonColor!
        
        self.backgroundColor = backgroundColor!
        
        guard let imageOptions = backgroundImageOptions else {
            return
        }
        
        self.backgroundImageOptions = imageOptions
    }
}

public extension UIView {
    
    /// Sets a corresponding `IGCStateView` to a `UIView` instance based on provided `IGCViewState`.
    ///
    /// - Parameter state: `IGCViewState` with its corresponding parameters.
    public func configureViewDataState(as state: IGCViewState) {
        switch state {
        case .loading(message: let message, styles: let styles):
            self.removeDataStateView()
            self.addSubview(loadingView(with: message, styles: styles))
        case .error(image: let image,
                    title: let title,
                    message: let message,
                    styles: let styles,
                    buttonAction: let buttonAction):
            self.removeDataStateView()
            self.addSubview(errorView(with: image,
                                      title: title,
                                      message: message,
                                      styles: styles,
                                      buttonAction: buttonAction))
        default:
            self.removeDataStateView()
        }
    }
    
    /// Returs a `IGCStateView` instance catered with error information.
    ///
    /// - Parameters:
    ///   - image: Icon to display to the state view.
    ///   - title: Title of the state view.
    ///   - message: Supplementary message of the state view.
    ///   - styles: `IGCStateViewStyles` instance to provide additional styling to the view.
    ///   - buttonAction: Closure to be executed when button is pressed.
    ///                   Not supplying this parameter will not display the button.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func errorView(with image: UIImage?,
                           title: String?,
                           message: String,
                           styles: IGCStateViewStyles?,
                           buttonAction: ((UIButton) -> Void)?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupStateView(with: ["message": message, "title": title],
                            image: image,
                            styles: styles,
                            forLoadingState: false,
                            buttonAction: buttonAction)
        
        return view
    }
    
    /// Returs a `IGCStateView` instance catered with loading information.
    ///
    /// - Parameters:
    ///   - message: Supplementary message of the state view.
    ///   - styles: `IGCStateViewStyles` instance to provide additional styling to the view.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func loadingView(with message: String? = nil, styles: IGCStateViewStyles?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupStateView(with: ["message": message],
                            image: nil,
                            styles: styles,
                            buttonAction: nil)
        
        return view
    }
    
    /// Removes current `IGCStateView` subview to make way for a new one.
    private func removeDataStateView() {
        for subview in self.subviews {
            if subview is IGCStateView {
                subview.removeFromSuperview()
                
                break
            }
        }
    }
    
}
