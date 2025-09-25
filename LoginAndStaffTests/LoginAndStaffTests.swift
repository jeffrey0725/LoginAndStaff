//
//  LoginAndStaffTests.swift
//  LoginAndStaffTests
//
//  Created by Jeffrey Cheung on 23/9/2025.
//

import Testing
import Foundation
import Combine
@testable import LoginAndStaff

struct LoginAndStaffTests {
    
    @Test func testLoginSuccess() async throws {
        let viewModel = LoginViewModel()
        viewModel.email = "eve.holt@reqres.in"
        viewModel.password = "cityslicka"
        
        var cancellables = Set<AnyCancellable>()
        
        viewModel.onLoginPress()
        
        await withCheckedContinuation { (continuation) in
            viewModel.$isLoggedIn
                .filter { $0 }
                .first()
                .sink { (_) in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
        
        #expect(viewModel.isLoggedIn == true)
        #expect(!StoreManager.shared.storeToken.isEmpty)
    }
    
    @Test func testLoginFailure() async throws {
        let viewModel = LoginViewModel()
        viewModel.email = "wrong@example.com"
        viewModel.password = "cityslicka"
        
        var cancellables = Set<AnyCancellable>()
        
        viewModel.onLoginPress()
        
        await withCheckedContinuation { (continuation) in
            viewModel.$isShowAlert
                .dropFirst()
                .filter { $0 }
                .first()
                .sink { (_) in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
        
        #expect(viewModel.isShowAlert == true)
        #expect(!viewModel.alertMessage.isEmpty)
    }
    
    @Test func testLoginValidation_emptyEmail() async throws {
        let viewModel = LoginViewModel()
        
        viewModel.email = ""
        viewModel.password = "cityslicka"
        
        viewModel.onLoginPress()
        
        #expect(viewModel.isShowAlert == true)
        #expect(viewModel.alertMessage == "Please enter both email and password")
    }
    
    @Test func testLoginValidation_invalidEmailFormat() async throws {
        let viewModel = LoginViewModel()
        
        viewModel.email = "invalid-email"
        viewModel.password = "cityslicka"
        
        viewModel.onLoginPress()
        
        #expect(viewModel.isShowAlert == true)
        #expect(viewModel.alertMessage == "Please enter valid email address")
    }
    
    @Test func testLoginValidation_invalidPassword() async throws {
        let viewModel = LoginViewModel()
        
        viewModel.email = "eve.holt@reqres.in"
        viewModel.password = "123"
        
        viewModel.onLoginPress()
        
        #expect(viewModel.isShowAlert == true)
        #expect(viewModel.alertMessage == "Please enter valid password")
    }
    
    @Test func testFetchStaffList() async throws {
        let viewModel = StaffListViewModel()
        var cancellables = Set<AnyCancellable>()
        
        viewModel.fetchStaffList()
        
        await withCheckedContinuation { (continuation) in
            viewModel.$staffList
                .dropFirst()
                .filter { !$0.isEmpty }
                .first()
                .sink { (_) in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
        
        #expect(!viewModel.staffList.isEmpty)
        #expect(viewModel.totalPages >= 1)
        #expect(viewModel.isLastPage == (viewModel.currentPage >= viewModel.totalPages))
    }
    
    @Test func testFetchStaffList_multiplePages() async throws {
        let viewModel = StaffListViewModel()
        var cancellables = Set<AnyCancellable>()
        
        viewModel.fetchStaffList()
        await withCheckedContinuation { (continuation) in
            viewModel.$staffList
                .dropFirst()
                .filter { !$0.isEmpty }
                .first()
                .sink { (_) in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
        
        let firstPageCount = viewModel.staffList.count
        
        viewModel.currentPage += 1
        viewModel.fetchStaffList()
        await withCheckedContinuation { (continuation) in
            viewModel.$staffList
                .dropFirst()
                .filter { $0.count > firstPageCount }
                .first()
                .sink { (_) in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
        
        #expect(viewModel.staffList.count > firstPageCount)
        #expect(viewModel.totalPages >= viewModel.currentPage)
        #expect(viewModel.isLastPage == (viewModel.currentPage >= viewModel.totalPages))
    }
}
