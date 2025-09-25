//
//  StoreManager.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 25/9/2025.
//

import Foundation

class StoreManager {
    static let shared = StoreManager()
    var storeToken: String = ""
    
    func storeToken(token: String) {
        storeToken = token
    }
    
    func clearToken() {
        storeToken = ""
    }
}
