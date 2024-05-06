//
//  UsersModel.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation

struct UsersModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case firstName, lastName, userTag, department, position, birthday, phone
    }
}
