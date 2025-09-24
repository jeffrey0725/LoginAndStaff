//
//  ContentView.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 23/9/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            // View title
            Text("LOGIN")
                .font(.title)
            
            // Email address text field
            TextField(text: $emailAddress, label: {
                Text("Email Address")
            })
            .borderWithRadius(10, .black, 2, 8, .clear)
            
            // Password text field
            TextField(text: $password, label: {
                Text("Password")
            })
            .borderWithRadius(10, .black, 2, 8, .clear)
            .padding(.top)
            
            // Login button
            Button(action: {
                
            }, label: {
                Text("Login")
                    .foregroundStyle(Color.black)
            })
            .borderWithRadius(10, .clear, 2, 8, .blue)
            .frame(maxWidth: .infinity)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    ContentView()
}
