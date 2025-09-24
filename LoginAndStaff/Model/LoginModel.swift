//
//  LoginModel.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 24/9/2025.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String?
    let error: String?
}
