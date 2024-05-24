//
//  UsersResponse.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/16/24.
//

// MARK: UsersResponse
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
