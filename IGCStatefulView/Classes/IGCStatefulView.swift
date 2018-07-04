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
    /// - styleParams: Dictionary containing either title, message, and/or image key-value pairs.
    ///                For `title` and `message`, `font` and `color` options are available.
    ///                For `image`, `size` option is available.
    ///                For `indicator`, `tint` option is available.
    case loading(message: String?, styleParams: [String: Any]?)
    /// An error state view will be displayed to indicate error on fetching data.
    /// - image: Image to be displayed.
    /// - title: Primary text to be displayed.
    /// - message: Supporting text to be displayed.
    /// - styleParams: Dictionary containing either title, message, and/or image key-value pairs.
    ///                For `title` and `message`, `font` and `color` options are available.
    ///                For `image`, `size` option is available.
    ///                For `indicator`, `tint` option is available.
    /// - buttonAction: Closure to be executed when button is pressed.
    ///                 Not supplying this parameter will not display the button.
    case error(
        image: UIImage?,
        title: String?,
        message: String,
        styleParams: [String: Any]?,
        buttonAction: ((UIButton) -> Void)?)
    /// Same behavior as `success`. May be used as default.
    case none
}

public extension UIView {
    
    /// Sets a corresponding `IGCStateView` to a `UIView` instance based on provided `IGCViewState`.
    ///
    /// - Parameter state: `IGCViewState` with its corresponding parameters.
    public func configureViewDataState(as state: IGCViewState) {
        switch state {
        case .loading(message: let message, styleParams: let styleParams):
            self.removeDataStateView()
            self.addSubview(loadingView(with: message, styleParams: styleParams))
        case .error(image: let image,
                    title: let title,
                    message: let message,
                    styleParams: let styleParams,
                    buttonAction: let buttonAction):
            self.removeDataStateView()
            self.addSubview(errorView(with: image,
                                      title: title,
                                      message: message,
                                      styleParams: styleParams,
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
    ///   - styleParams: Dictionary containing either `title`, `message`, `image`, `indicator`, and/or `button` key-value pairs.
    ///                  For `title`, `message`, and `button`, `font` and `color` options are available.
    ///                  For `image`, `size` option is available.
    ///                  For `indicator`, `tint` option is available.
    ///   - buttonAction: Closure to be executed when button is pressed.
    ///                   Not supplying this parameter will not display the button.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func errorView(with image: UIImage?,
                           title: String?,
                           message: String,
                           styleParams: [String: Any]?,
                           buttonAction: ((UIButton) -> Void)?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupStateView(with: ["message": message, "title": title],
                            image: image,
                            styleParams: styleParams,
                            forLoadingState: false,
                            buttonAction: buttonAction)
        
        return view
    }
    
    /// Returs a `IGCStateView` instance catered with loading information.
    ///
    /// - Parameters:
    ///   - message: Supplementary message of the state view.
    ///   - styleParams: Dictionary containing either title, message, and/or image key-value pairs.
    ///                  For `title` and `message`, `font` and `color` options are available.
    ///                  For `image`, `size` option is available.
    ///                  For `indicator`, `tint` option is available.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func loadingView(with message: String? = nil, styleParams: [String: Any]?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupStateView(with: ["message": message],
                            image: nil,
                            styleParams: styleParams,
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
