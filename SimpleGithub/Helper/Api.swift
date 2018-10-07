//
//  Api.swift
//  SimpleGithub
//
//  Created by Wmotion Mac 101 on 10/6/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

private struct Base {
    static let url = "https://api.github.com"
}

struct Api {
    static func getAllUser(page: Int, onCompletion: @escaping([User]?, Error?)->()) {
        let url = Base.url + "/users"
        let parameters = ["per_page" : page]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                if json.arrayValue.count > 0 {
                    var users = [User]()
                    for result in json.arrayValue {
                        let user = User(json: result)
                        users.append(user)
                    }
                    
                    onCompletion(users, nil)
                } else {
                    onCompletion(nil, nil)
                }
                break
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    
    static func getAvatar(withUrl url: String, onCompletion: @escaping(UIImage)->()) {
        
        Alamofire.request(url).responseImage { (response) in
            switch response.result {
            case .success:
                if let image = response.result.value {
                    onCompletion(image)
                } else {
                    onCompletion(UIImage(named: "default")!)
                }
            case .failure(let error):
                print(error)
                onCompletion(UIImage(named: "error")!)
            }
        }
    }
}
