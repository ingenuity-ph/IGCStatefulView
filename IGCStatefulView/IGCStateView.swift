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
        let bundle = Bundle(identifier: "com.ingenuitymobile.IGCStatefulView")!
        
        bundle.loadNibNamed("StateView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: Public Methods
    
    func setupInfo(with params: [String: String?], image: UIImage?, forLoadingState: Bool = true) {
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
    }
    
}

