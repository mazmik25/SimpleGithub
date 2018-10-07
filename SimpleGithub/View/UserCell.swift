//
//  UserCell.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/5/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var user: User! {
        didSet {
            self.userName.text = user.name
            Api.getAvatar(withUrl: user.avatarUrl) { (image) in
                self.userAvatar.image = image
                self.userAvatar.layer.borderColor = UIColor.black.cgColor
                self.userAvatar.layer.borderWidth = 1
                self.userAvatar.layer.cornerRadius = self.userAvatar.layer.frame.height / 2
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
