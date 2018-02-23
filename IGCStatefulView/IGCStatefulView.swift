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
    case loading(message: String?)
    case error(image: UIImage?, title: String?, message: String)
    case none
}

public extension UIView {
    
    public func setViewDataState(_ state: IGCViewState) {
        switch state {
        case .loading(let message):
            self.removeDataStateView()
            self.addSubview(loadingView(with: message))
        case .error(image: let image, title: let title, message: let message):
            self.removeDataStateView()
            self.addSubview(errorView(with: image, title: title, message: message))
        default:
            self.removeDataStateView()
        }
    }
    
    private func errorView(with image: UIImage?, title: String?, message: String) -> UIView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message, "title": title],
                       image: image,
                       forLoadingState: false)
        
        return view
    }
    
    private func loadingView(with message: String? = nil) -> UIView {
        let view = IGCStateView(frame: self.bounds)
        
        view.setupInfo(with: ["message": message], image: nil)
        
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
