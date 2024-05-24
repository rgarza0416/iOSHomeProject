//
//  CreateValidatorFailureMock.swift
//  iOSHomeProjectTests
//
//  Created by Ricardo Garza on 5/23/24.
//


import Foundation
@testable import iOSHomeProject

struct CreateValidatorFailureMock: CreateValidatorImpl {
    func validate(_ person: iOSHomeProject.NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
