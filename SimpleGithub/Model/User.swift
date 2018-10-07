//
//  User.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/5/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKeys {
    static let id = "id"
    static let name = "login"
    static let avatarUrl = "avatar_url"
    static let url = "html_url"
}

struct User {
    
    var id: Int = 0
    var name: String = ""
    var avatarUrl: String = ""
    var url: String = ""
    
    init(json: JSON) {
        self.id = json[SerializationKeys.id].intValue
        self.name = json[SerializationKeys.name].stringValue
        self.avatarUrl = json[SerializationKeys.avatarUrl].stringValue
        self.url = json[SerializationKeys.url].stringValue
    }
}
