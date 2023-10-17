//
//  LoginView2.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 17/10/2023.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct LoginView2: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginError: String? = nil
    @State private var isLogged: Bool = false
    
    @State private var authenticate:Bool = UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID")
    
    @EnvironmentObject private var userInfo: userInfo

    var body: some View {
        VStack {
//            TextField("Email", text: $email)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
            
            TextField("Email", text: $email)
                       .onChange(of: email) { newValue in
                           if(newValue.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                               
                               self.loginError = nil
                                                              
                           } else {
                               
                               self.loginError = "Invalid email"
                               
                           }
                       }
                       .padding()
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.yellow, lineWidth: 0.5)
                       )
                       .keyboardType(.emailAddress)
                       .padding(.top, 42)
                       .autocapitalization(.none)

            
            SecureField("Password", text: $password)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 0.5)
                )
            
            if let error = loginError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            NavigationLink(destination: SuccessView(), isActive: $isLogged) {
                EmptyView()
            }
            
            HStack{
                Button(action: {
                    // Implement login logic here
                    self.login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .padding(6)
                        .frame(maxWidth:.infinity)
                        .frame(height: 45)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(6)
                if authenticate {
                    
                    Button(action: {
                        authenticateWithFaceID()
                    }) {
                        Image(systemName:"faceid")
                            .font(.headline)
                            .padding(6)
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    
                    .padding(6)
                    
                }
            }.padding(8)

        }
        .onAppear{
            authenticate = UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID")
            loginError = nil
        }
        .onDisappear{
            password = ""
            email = ""
            loginError = nil
            
        }
        .padding()
        .navigationTitle("Login")
    }
    
    func login() {
        guard let savedPassword = KeychainHelper.retrievePassword(forAccount: email) else {
            loginError = "Invalid email or password"
            return
        }
        
        if password == savedPassword {
            // Navigate to the success view
            self.isLogged = true
//            userInfo.email = email
        } else {
            loginError = "Invalid email or password"
        }
    }
    
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID and the user has enrolled in it
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to login using Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful, retrieve the password from Keychain
                        if let savedPassword = KeychainHelper.retrievePassword(forAccount: email) {
                            password = savedPassword
                            self.login()
                        } else {
                            print("Password not found in Keychain for the provided email")
                        }
                    } else {
                        // Authentication failed
                        print("Face ID authentication failed")
                    }
                }
            }
        } else {
            // Device doesn't support Face ID or the user hasn't enrolled
            print("Face ID is not available")
        }
    }
    
    
    
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2()
    }
}
