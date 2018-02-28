//
//  IGCStateView.swift
//  IGCStatefulView
//
//  Created by Jason Jon E. Carreos on 23/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import UIKit

final class IGCStateView: UIView {
    
    // MARK: Properties
    
    private var action: (UIButton) -> Void = {_ in }
    
    // MARK: Outlets
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: Private Methods
    
    private func setup() {
        let bundle = Bundle(for: IGCStateView.self)
        
        bundle.loadNibNamed("StateView", owner: self, options: nil)
        
        self.button.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
        // Content View
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @objc private func onButtonTap() {
        self.action(self.button)
    }
    
    // MARK: Public Methods
    
    /// Configures the `IGCStateView` given the provided parameters.
    ///
    /// - Parameters:
    ///   - params: Dictionary containing `title`, and/or `message`.
    ///   - image: Icon to be displayed in the view.
    ///   - styleParams: Dictionary containing the style attributes for each component.
    ///                  `title` and `message` can be configured by suppling `font` and `color`, while the
    ///                  `image` can be updated by `size`.
    ///   - forLoadingState: Determines if view is for loading state.
    ///   - buttonAction: Closure to be executed when button is pressed.
    ///                   Not supplying this parameter will not display the button.
    func setupInfo(with params: [String: String?],
                   image: UIImage?,
                   styleParams: [String: Any]?,
                   forLoadingState: Bool = true,
                   buttonAction: ((UIButton) -> Void)?) {
        // Content
        self.imageView.isHidden = forLoadingState
        self.centerConstraint.constant = 30
        
        self.titleLabel.updateConstraints()
        
        if forLoadingState {
            self.indicatorView.startAnimating()
        } else {
            self.indicatorView.stopAnimating()
            
            if let image = image {
                self.imageView.image = image
            } else {
                self.centerConstraint.constant = 0
                
                self.titleLabel.updateConstraints()
            }
        }
        
        if let title = params["title"] as? String {
            self.titleLabel.text = title
        }
        
        if let message = params["message"] as? String {
            self.messageLabel.text = message
        }
        
        if let action = buttonAction {
            self.action = action
            self.button.isHidden = false
            
            self.button.addTarget(self, action: #selector(self.onButtonTap), for: .touchUpInside)
        }
        
        // Style
        guard let styleParams = styleParams else {
            return
        }
        
        if let titleStyleParams = styleParams["title"] as? [String: Any] {
            if let font = titleStyleParams["font"] as? UIFont {
                self.titleLabel.font = font
            }
            
            if let color = titleStyleParams["color"] as? UIColor {
                self.titleLabel.textColor = color
            }
        }
        
        if let messageStyleParams = styleParams["message"] as? [String: Any] {
            if let font = messageStyleParams["font"] as? UIFont {
                self.messageLabel.font = font
            }
            
            if let color = messageStyleParams["color"] as? UIColor {
                self.messageLabel.textColor = color
            }
        }
        
        if let imageStyleParams = styleParams["image"] as? [String: Any] {
            if let size = imageStyleParams["size"] {
                self.heightConstraint.constant = CGFloat(size as! Int)
                
                
                self.imageView.updateConstraints()
            }
        }
        
        if let indicatorStyleParams = styleParams["indicator"] as? [String: Any] {
            if let tintColor = indicatorStyleParams["tint"] as? UIColor {
                self.indicatorView.tintColor = tintColor
            }
        }
        
        if let buttonStyleParams = styleParams["button"] as? [String: Any] {
            if let font = buttonStyleParams["font"] as? UIFont {
                self.button.titleLabel?.font = font
            }
            
            if let color = buttonStyleParams["color"] as? UIColor {
                self.button.tintColor = color
            }
        }
    }
    
}
