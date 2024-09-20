//
//  User.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 19/9/24.
//

import Foundation

struct User: Codable {
    
    var id: String
    var username: String
    var email: String
    var gender: String
    var aboutMe: String
    var profileImage: String
    var birthday: String
    
}
