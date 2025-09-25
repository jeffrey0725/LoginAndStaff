//
//  CustomViewModel.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 24/9/2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var alertMessage: String = ""
    @Published var isShowAlert: Bool = false
    @Published var isLoadingApi: Bool = false
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func validateEmail() -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validatePassword() -> Bool {
        let passwordRegEx = "^[A-Za-z0-9]{6,10}$"
        let passwordPref = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPref.evaluate(with: password)
    }
    
    func onLoginPress() {
        if !email.isEmpty && !password.isEmpty {
            // validate email
            if !validateEmail() {
                alertMessage = "Please enter valid email address"
                isShowAlert = true
                return
            } else if !validatePassword() {
                alertMessage = "Please enter valid password"
                isShowAlert = true
                return
            } else {
                // passed local checking
                isLoadingApi = true
                NetworkManager.shared.request(ApiDomain().domain + ApiPath().login,
                                              "POST",
                                              [:],
                                              ["delay": "5"],
                                              LoginRequest(email: email, password: password))
                    .sink(receiveCompletion: { (completion) in
                        switch completion {
                        case .finished:
                            break;
                        case .failure(let error):
                            print("debug error: \(error.localizedDescription)")
                            self.alertMessage = error.localizedDescription
                            self.isShowAlert = true
                        }
                    }, receiveValue: { (response: LoginResponse) in
                        self.isLoadingApi = false
                        // check if token returne
                        if let _token = response.token {
                            StoreManager.shared.storeToken(token: _token)
                            self.isLoggedIn = true
                            return
                        }
                        
                        if let _error = response.error {
                            self.alertMessage = _error
                            self.isShowAlert = true
                        }
                    })
                    .store(in: &cancellables)
                return
            }
        }
        
        alertMessage = "Please enter both email and password"
        isShowAlert = true
    }
}
