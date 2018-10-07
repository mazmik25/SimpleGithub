//
//  BaseViewController.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/5/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit
import Toast_Swift

struct Duration {
    static let LONG = 10.0
    static let MEDIUM = 5.0
    static let SHORT = 3.0
}

class BaseViewController: UIViewController {
    
    var loadingView: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()

        ToastManager.shared.isTapToDismissEnabled = true
    }
    
    func initToast(color: UIColor, message: String, duration: Double, position: ToastPosition) {
        var style = ToastStyle()
        style.messageColor = color
        self.view.makeToast(message, duration: duration, position: position, style: style)
    }
    
    func connectionError() {
        self.initToast(color: .red, message: "Failed to connect to server", duration: Duration.SHORT, position: .bottom)
    }
    
    func emptyData() {
        self.initToast(color: .gray, message: "Data are empty", duration: Duration.SHORT, position: .bottom)
    }
    
    func showLoading(view: UIView) {
        self.loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: [:])[0] as? LoadingView
        self.loadingView?.show(inView: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        self.loadingView?.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func initNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.gray
    }
}
