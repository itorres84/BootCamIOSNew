//
//  Profile.swift
//  LoginFacebook
//
//  Created by Israel Torres Alvarado on 14/04/21.
//

import Foundation

struct Profile: Codable {
    let id: String
    let email: String
    let name: String
    let picture: Picture
}

struct Picture: Codable {
    let data: DataPicture
}

struct DataPicture: Codable {
    let url: String
}
