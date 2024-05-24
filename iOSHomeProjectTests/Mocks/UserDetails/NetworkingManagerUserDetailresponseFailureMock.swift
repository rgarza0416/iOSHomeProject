//
//  NetworkingManagerUserDetailresponseFailureMock.swift
//  iOSHomeProjectTests
//
//  Created by Ricardo Garza on 5/23/24.
//

import Foundation
@testable import iOSHomeProject

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        
    }
}
