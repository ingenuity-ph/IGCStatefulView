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
/// - success: No state view will be displayed since actual `UIView` content is available.
/// - loading: A loading state view will be displayed to indicate fetching and populating of data.
/// - error: An error state view will be displayed to indicate error on fetching data.
/// - none: Same behavior as `success`. May be used as default.
public enum IGCViewState {
    case success
    case loading(message: String?, styleParams: [String: Any]?)
    case error(image: UIImage?, title: String?, message: String, styleParams: [String: Any]?)
    case none
}

public extension UIView {
    
    /// Sets a corresponding `IGCStateView` to a `UIView` instance based on provided `IGCViewState`.
    ///
    /// - Parameter state: `IGCViewState` with its corresponding parameters.
    public func setViewDataState(_ state: IGCViewState) {
        switch state {
        case .loading(message: let message, styleParams: let styleParams):
            self.removeDataStateView()
            self.addSubview(loadingView(with: message, styleParams: styleParams))
        case .error(image: let image, title: let title, message: let message, styleParams: let styleParams):
            self.removeDataStateView()
            self.addSubview(errorView(with: image, title: title, message: message, styleParams: styleParams))
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
    ///   - styleParams: Dictionary containing either title, message, image keys containing
    ///                  dictionary values with either font, color, size key-values for styling.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func errorView(with image: UIImage?,
                           title: String?,
                           message: String,
                           styleParams: [String: Any]?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message, "title": title],
                       image: image,
                       styleParams: styleParams,
                       forLoadingState: false)
        
        return view
    }
    
    /// Returs a `IGCStateView` instance catered with loading information.
    ///
    /// - Parameters:
    ///   - message: Supplementary message of the state view.
    ///   - styleParams: Dictionary containing either title, message, image keys containing
    ///                  dictionary values with either font, color, size key-values for styling.
    /// - Returns: A `IGCStateView` instance configured with supplied parameters.
    private func loadingView(with message: String? = nil, styleParams: [String: Any]?) -> IGCStateView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message],
                       image: nil,
                       styleParams: styleParams)
        
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
