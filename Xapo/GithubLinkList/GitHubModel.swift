//
//  GitHubModel.swift
//  Xapo
//
//  Created by sabaz shereef on 31/12/21.
//

import Foundation
// MARK: - UserCreateElement

struct GitHubModel: Codable {
    let author, name: String?
    let avatar: String?
    let url: String?
    let description, language, languageColor: String?
    let stars, forks, currentPeriodStars: Int?
    let builtBy: [BuiltBy]

//    enum CodingKeys: String, CodingKey {
//        case author, name, avatar, url
//        case userCreateDescription = "description"
//        case language, languageColor, stars, forks, currentPeriodStars, builtBy
//    }
}

// MARK: - BuiltBy
struct BuiltBy: Codable {
    let href, avatar: String?
    let username: String?
}

//typealias UserCreate = [UserCreateElement]
