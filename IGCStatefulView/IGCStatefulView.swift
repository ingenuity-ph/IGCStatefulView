//
//  IGCStatefulView.swift
//  IGCStatefulView
//
//  Created by Jason Jon E. Carreos on 23/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import Foundation
import UIKit

public enum IGCViewState {
    case success
    case loading(message: String?, styleParams: [String: Any]?)
    case error(image: UIImage?, title: String?, message: String, styleParams: [String: Any]?)
    case none
}

public extension UIView {
    
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
    
    private func errorView(with image: UIImage?,
                           title: String?,
                           message: String,
                           styleParams: [String: Any]?) -> UIView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message, "title": title],
                       image: image,
                       styleParams: styleParams,
                       forLoadingState: false)
        
        return view
    }
    
    private func loadingView(with message: String? = nil, styleParams: [String: Any]?) -> UIView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message],
                       image: nil,
                       styleParams: styleParams)
        
        return view
    }
    
    private func removeDataStateView() {
        for subview in self.subviews {
            if subview is IGCStateView {
                subview.removeFromSuperview()
                
                break
            }
        }
    }
    
}
