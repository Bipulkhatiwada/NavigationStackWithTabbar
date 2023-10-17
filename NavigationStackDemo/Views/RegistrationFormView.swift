//
//  RegistrationFormView.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 17/10/2023.
//

import Foundation
import SwiftUI

struct RegistrationFormView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistered: Bool = false
    @State private var registrationError: String? = nil

    
    private var isRegisterButtonDisabled: Bool {
        return name.isEmpty || email.isEmpty || password.isEmpty || registrationError != nil
    }
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
                .autocapitalization(.words)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 0.5)
                )
            
            TextField("Email", text: $email)
                       .onChange(of: email) { newValue in
                           if(newValue.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                               
                               self.registrationError = nil
                                                              
                           } else {
                               
                               self.registrationError = "Invalid email"
                               
                           }
                       }
                       .padding()
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.yellow, lineWidth: 0.5)
                       )
                       .keyboardType(.emailAddress)
                            .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 0.5)
                )
            if let error = registrationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            NavigationLink(destination: LoginView2(), isActive: $isRegistered) {
                EmptyView()
            }
            
            Button(action: {
                // Save the name and password to Keychain
                KeychainHelper.savePassword(password, forAccount: email)
                print("Registered with Name: \(name), Email: \(email), Password saved to Keychain")
                // Navigate to the login screen
                self.isRegistered = true
            }) {
                Text("Register")
                    .font(.headline)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isRegisterButtonDisabled)
            .padding()
        }
        .padding()
        .navigationTitle("Registration")
    }
}


struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
