//
//  StaffListModel.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 25/9/2025.
//

import Foundation

struct StaffListRequest: Encodable {
    
}

struct StaffListResponse: Decodable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [StaffListData]?
}

struct StaffListData: Decodable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
}
