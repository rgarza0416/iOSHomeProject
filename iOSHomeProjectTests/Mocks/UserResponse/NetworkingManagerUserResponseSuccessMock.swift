//
//  NetworkingManagerUserResponseSuccessMock.swift
//  iOSHomeProjectTests
//
//  Created by Ricardo Garza on 5/23/24.
//


import Foundation
@testable import iOSHomeProject

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {

    }
}
