//
//  StaffListView.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 25/9/2025.
//

import SwiftUI

struct StaffListView: View {
    @StateObject private var staffViewModel = StaffListViewModel()
    
    var body: some View {
        VStack {
            // stored login token
            Text("Login token: \(StoreManager.shared.storeToken)")
            
            // staff list
            List() {
                ForEach(staffViewModel.staffList, id: \.id) { (staff) in
                    StaffListItemView(staff: staff)
                }
                
                // If not last page show load button
                if !staffViewModel.isLastPage {
                    Button(action: {
                        staffViewModel.currentPage += 1
                        staffViewModel.fetchStaffList()
                    }, label: {
                        Text("Load")
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity)
                    })
                    .borderWithRadius(10, .clear, 2, 8, .red)
                }
            }
            .listStyle(.inset)
        }
        .navigationTitle("Staff List")
        .onAppear() {
            // call api to get staff list when enter view
            staffViewModel.fetchStaffList()
        }
        
        Spacer()
    }
}

#Preview {
    StaffListView()
}
