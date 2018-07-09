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
    @IBOutlet private weak var backgroundImageView: UIImageView!
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
    ///   - styles: `IGCStateViewStyles` instance to provide additional styling to the view.
    ///   - forLoadingState: Determines if view is for loading state.
    ///   - buttonAction: Closure to be executed when button is pressed.
    ///                   Not supplying this parameter will not display the button.
    func setupStateView(with params: [String: String?],
                        image: UIImage?,
                        styles: IGCStateViewStyles?,
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
        
        if let action = buttonAction {
            self.action = action
            self.button.isHidden = false
            
            self.button.addTarget(self, action: #selector(self.onButtonTap), for: .touchUpInside)
        }
        
        self.setupInfo(params)
        
        // Style
        guard let styles = styles else {
            return
        }
        
        self.setupStyle(styles)
    }
    
    /// Set various info messages to this instance.
    ///
    /// - Parameter infoParams: `Dictionary` instance containing necessary strings to pre-defined properties.
    private func setupInfo(_ infoParams: [String: String?]) {
        if let title = infoParams["title"] as? String {
            self.titleLabel.text = title
        }
        
        if let message = infoParams["message"] as? String {
            self.messageLabel.text = message
        }
    }
    
    /// Applies styling to this instance based on provided dictionary.
    ///
    /// - Parameter styles: `IGCStateViewStyles` instance containing necessary styling to pre-defined properties.
    private func setupStyle(_ styles: IGCStateViewStyles) {
        self.titleLabel.font = styles.titleFont
        self.titleLabel.textColor = styles.titleColor
        
        self.messageLabel.font = styles.messageFont
        self.messageLabel.textColor = styles.messageColor
        
        self.heightConstraint.constant = styles.imageSize
        
        self.indicatorView.tintColor = styles.indicatorTintColor
        
        self.button.titleLabel?.font = styles.buttonFont
        self.button.tintColor = styles.buttonColor
        
        self.imageView.updateConstraints()
        
        guard let imageOptions = styles.backgroundImageOptions else {
            self.backgroundImageView.backgroundColor = styles.backgroundColor
            
            return
        }
        
        self.backgroundImageView.image = imageOptions.image
        self.backgroundImageView.contentMode = imageOptions.contentMode
    }
    
}
