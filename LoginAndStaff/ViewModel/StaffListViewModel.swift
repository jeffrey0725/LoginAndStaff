//
//  StaffListViewModel.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 25/9/2025.
//

import Foundation
import Combine

class StaffListViewModel: ObservableObject {
    @Published var staffList: [StaffListData] = []
    @Published var currentPage: Int = 1
    @Published var totalPages: Int = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    var isLastPage: Bool {
        totalPages <= currentPage
    }
    
    func fetchStaffList() {
        NetworkManager.shared.request(ApiDomain().domain + ApiPath().users,
                                      "GET",
                                      [:],
                                      ["page": String(currentPage)],
                                      StaffListRequest())
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                break;
            case .failure(let error):
                print("debug error: \(error.localizedDescription)")
            }
        }, receiveValue: { (response: StaffListResponse) in
            if let _total_pages = response.total_pages {
                self.totalPages = _total_pages
            }
            
            if let _data = response.data {
                self.staffList.append(contentsOf: _data)
            }
        })
        .store(in: &cancellables)
    }
}
