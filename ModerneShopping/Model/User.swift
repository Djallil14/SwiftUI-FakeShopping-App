//
//  User.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-05.
//

import Foundation
struct UserAPIResults: Codable {
    var results: [User]
    var info: APIInfo
}
struct User: Codable {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var picture: Picture
}
struct Name: Codable {
    var title: String
    var first: String
    var last: String
}

struct Location: Codable {
    var city: String
    var state: String
    var coordinates: Coordinate
    
}
struct Coordinate: Codable {
    var latitude: String
    var longitude: String
}

struct Login: Codable {
    var uuid: String
    var username: String
    var password: String
}

struct APIInfo: Codable{
    var seed: String
    var results: Int
    var page: Int
    var version: String
}

struct Picture: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}



extension UserAPIResults {
    static var sampleUsers: UserAPIResults {
        let response: UserAPIResults? = try? Bundle.main.loadAndDecodeJSON(filename: "api")
        return response ?? UserAPIResults(results: [], info: APIInfo(seed: "", results: 1, page: 1, version: ""))
    }
}
