//
//  AuthenticationHelper.swift
//  NavigationStackDemo
//
//  Created by Bipul Khatiwada on 16/10/2023.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper
import LocalAuthentication

import SwiftUI

class userInfo: ObservableObject {
    @Published var email: String = ""
}


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

import SwiftUI

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


import Foundation
import Security

struct KeychainHelper {
    private static let serviceName: String = "NavigationStackDemo"
    
    static func savePassword(_ password: String, forAccount account: String) {
        if let data = password.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: serviceName,
                kSecAttrAccount as String: account,
                kSecValueData as String: data
            ]
            
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Failed to save password to Keychain. Status: \(status)")
                return
            }
        }
    }
    
    static func retrievePassword(forAccount account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data, let password = String(data: retrievedData, encoding: .utf8) {
            return password
        } else {
            print("Failed to retrieve password from Keychain. Status: \(status)")
            return nil
        }
    }
}
import SwiftUI

struct SuccessView: View {
    @State private var savePasswordUsingFaceID: Bool = UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID")
    @State private var isPasswordSaved: Bool = false
    
    var body: some View {
        VStack {
            Text("Login Successful!")
                .padding()
            
            Toggle(isOn: $savePasswordUsingFaceID, label: {
                Text("enable faceId for login")
            })
            .padding()
            
//            Button(action: {
//                if savePasswordUsingFaceID {
//                    savePasswordToKeychain()
//                } else {
//                    removePasswordFromKeychain()
//                }
//            }) {
//                Text(savePasswordUsingFaceID ? "Save Password" : "Remove Password")
//                    .font(.headline)
//                    .padding()
//                    .frame(width: 200, height: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
        }
        .onAppear{
            print(UserDefaults.standard.bool(forKey: "savePasswordUsingFaceID"))
        }
        .onChange(of: savePasswordUsingFaceID, perform: { status in
            if status {
                savePasswordToKeychain()
            } else {
                removePasswordFromKeychain()
            }
        })
        .padding()
        .navigationTitle("Success")
    }
    
   
    private func savePasswordToKeychain() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID and the user has enrolled in it
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to save the password using Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful, save the password to Keychain
                        savePasswordUsingBiometrics()
                        savePasswordUsingFaceID = true
                    } else {
                        // Authentication failed
                        removePasswordFromKeychain()
                        savePasswordUsingFaceID = false
                    }
                }
            }
        } else {
            // Device doesn't support Face ID or the user hasn't enrolled
            print("Face ID is not available")
        }
    }

    private func savePasswordUsingBiometrics() {
        isPasswordSaved = true
        // Save the toggle state to UserDefaults
        UserDefaults.standard.set(savePasswordUsingFaceID, forKey: "savePasswordUsingFaceID")
    }
    
    private func removePasswordFromKeychain() {
        // Replace with your logic to remove the password from Keychain
        isPasswordSaved = false
        
        // Save the toggle state to UserDefaults
        UserDefaults.standard.set(savePasswordUsingFaceID, forKey: "savePasswordUsingFaceID")
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}




