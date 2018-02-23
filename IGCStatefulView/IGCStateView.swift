//
//  IGCStateView.swift
//  IGCStatefulView
//
//  Created by Jason Jon E. Carreos on 23/02/2018.
//  Copyright © 2018 Ingenuity Global Consulting, Inc. All rights reserved.
//

import UIKit

final class IGCStateView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
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
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: Public Methods
    
    func setupInfo(with params: [String: String?],
                   image: UIImage?,
                   styleParams: [String: Any]?,
                   forLoadingState: Bool = true) {
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
    }
    
}
