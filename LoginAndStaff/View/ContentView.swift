//
//  ContentView.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 23/9/2025.
//

import SwiftUI

struct ContentView: View {
    enum TextFieldType: Hashable {
        case email
        case password
    }
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    @FocusState private var focusedTextField: TextFieldType?
    
    var body: some View {
        VStack {
            // View title
            Text("LOGIN")
                .font(.title)
            
            // Email address text field
            TextField(text: $loginViewModel.email, label: {
                Text("Email Address")
            })
            .borderWithRadius(10, .black, 2, 8, .clear)
            .submitLabel(.next)
            .focused($focusedTextField, equals: .email)
            .onSubmit {
                focusedTextField = .password
            }
            
            // Password text field
            SecureField(text: $loginViewModel.password, label: {
                Text("Password")
            })
            .borderWithRadius(10, .black, 2, 8, .clear)
            .padding(.top)
            .focused($focusedTextField, equals: .password)
            .onSubmit {
                // reset focused textfield
                focusedTextField = nil
            }
            
            // Login button
            Button(action: {
                loginViewModel.onLoginPress()
            }, label: {
                Text("Login")
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity)
            })
            .borderWithRadius(10, .clear, 2, 8, .blue)
        }
        .padding()
        .alert(loginViewModel.alertMessage, isPresented: $loginViewModel.isShowAlert, actions: {
            Button(action: {
                // reset show alert state and alert message
                loginViewModel.isShowAlert = false
                loginViewModel.alertMessage = ""
            }, label: {
                Text("OK")
            })
        })
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
