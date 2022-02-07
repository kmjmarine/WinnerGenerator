//
//  UserList.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/07.
//

import Foundation

struct UserList: Codable {
    let id: Int
    let team: String
    let nickname: String
    let age: Int
    let imageURL: String
    let rank: Int
}
