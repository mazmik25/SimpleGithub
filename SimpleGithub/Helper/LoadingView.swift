//
//  LoadingView.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/6/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    func show(inView view: UIView) {
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        self.loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(self)
    }
    
    func dismiss() {
        self.indicatorView.stopAnimating()
        self.removeFromSuperview()
    }

}
