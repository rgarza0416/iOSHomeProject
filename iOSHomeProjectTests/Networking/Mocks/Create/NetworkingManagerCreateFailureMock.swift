//
//  NetworkingManagerCreateFailureMock.swift
//  iOSHomeProjectTests
//
//  Created by Ricardo Garza on 5/23/24.
//


import Foundation
@testable import iOSHomeProject

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidURL
    }
}
