//
//  Models.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/16/24.
//

import Foundation

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
