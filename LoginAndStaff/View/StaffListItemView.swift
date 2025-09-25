//
//  StaffListItemView.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 25/9/2025.
//

import SwiftUI

struct StaffListItemView: View {
    let staff: StaffListData
    
    var body: some View {
        HStack {
            // Image - Avatar
            AsyncImage(url: URL(string: staff.avatar ?? ""))
                .frame(width: 100, height: 100)
                .cornerRadius(100 / 2)
            VStack {
                // Text - First name + Last name
                Text("Name: \(staff.first_name ?? "") \(staff.last_name ?? "")")
                // Text - Email
                Text("Email: \(staff.email ?? "")")
            }
        }
    }
}

#Preview {
    StaffListItemView(staff: StaffListData(id: nil, email: nil, first_name: nil, last_name: nil, avatar: nil))
}
